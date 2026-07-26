// original source: https://github.com/itayinbarr/little-coder/blob/main/.pi/extensions/extra-tools/index.ts
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "@sinclair/typebox";

export default function (pi: ExtensionAPI) {
  pi.registerTool({
    name: "web_fetch",
    label: "WebFetch",
    description: "Fetch a URL and return its text content (HTML stripped). Capped at 25K chars.",
    parameters: Type.Object({
      url: Type.String({ description: "URL to fetch" }),
      prompt: Type.Optional(Type.String({ description: "Hint for what to extract (informational)" })),
    }),
    async execute(_id, { url }) {
      try {
        const controller = new AbortController();
        const timer = setTimeout(() => controller.abort(), 30_000);
        const res = await fetch(url, {
          headers: { "User-Agent": "pi-coding-agent/0.1" },
          redirect: "follow",
          signal: controller.signal,
        });
        clearTimeout(timer);
        if (!res.ok) {
          return {
            content: [{ type: "text", text: `Error: HTTP ${res.status} ${res.statusText}` }],
            details: {},
            isError: true,
          };
        }
        const ct = res.headers.get("content-type") || "";
        let text = await res.text();
        if (ct.includes("html")) {
          text = text.replace(/<script[^>]*>[\s\S]*?<\/script>/gi, "");
          text = text.replace(/<style[^>]*>[\s\S]*?<\/style>/gi, "");
          text = text.replace(/<[^>]+>/g, " ");
          text = text.replace(/\s+/g, " ").trim();
        }
        if (text.length > 25_000) text = text.slice(0, 25_000);
        return { content: [{ type: "text", text }], details: {} };
      } catch (e) {
        return {
          content: [{ type: "text", text: `Error: ${(e as Error).message}` }],
          details: {},
          isError: true,
        };
      }
    },
  });

  pi.registerTool({
    name: "web_search",
    label: "WebSearch",
    description: "Search the web via DuckDuckGo and return the top ~8 results as Markdown. Supports an optional page number.",
    parameters: Type.Object({
      query: Type.String({ description: "Search query" }),
      page: Type.Optional(
        Type.Integer({ description: "Page number of results to retrieve (1-based)", default: 1, minimum: 1 })
      ),
    }),
    async execute(_id, { query, page }) {
      try {
        const base = "https://html.duckduckgo.com/html/";
        const pageNumber = typeof page === "number" && page >= 1 ? page : 1;

        const controller = new AbortController();
        const timer = setTimeout(() => controller.abort(), 30_000);

        let res: Response;
        if (pageNumber <= 1) {
          res = await fetch(`${base}?q=${encodeURIComponent(query)}`, {
            headers: { "User-Agent": "Mozilla/5.0 (compatible)" },
            redirect: "follow",
            signal: controller.signal,
          });
        } else {
          const tokenRes = await fetch(`${base}?q=${encodeURIComponent(query)}`, {
            headers: { "User-Agent": "Mozilla/5.0 (compatible)" },
            redirect: "follow",
            signal: controller.signal,
          });
          if(!tokenRes.ok) {
            clearTimeout(timer);
            return {
              content: [{ type: "text", text: `Error: HTTP ${tokenRes.status} ${tokenRes.statusText}`}],
              details: {},
              isError: true,
            };
          }
          const tokenHtml = await tokenRes.text();
          const vqd = tokenHtml.match(/name="vqd" value="([^"]+)"/i)?.[1];
          const kl = tokenHtml.match(/name="kl" value="([^"]+)"/i)?.[1] ?? "wt-wt";
          if (!vqd) {
            clearTimeout(timer);
            return {
              content: [{ type: "text", text: "Error: DuckDuckGo did not return a pagination token."}],
              details: {},
              isError: true,
            };
          }
          const offset = (pageNumber - 1) * 10;
          res = await fetch(
            `${base}?q=${encodeURIComponent(query)}&s=${offset}&dc=${offset + 1}&v=l&o=json&api=d.js&vqd=${encodeURIComponent(vqd)}&kl=${encodeURIComponent(kl)}&nextParams=`,
            {
              headers: { "User-Agent": "Mozilla/5.0 (compatible)" },
              redirect: "follow",
              signal: controller.signal,
            },
          );
        }

        clearTimeout(timer);
        const body = await res.text();
        const titleRe = /class="result__title"[^>]*>[\s\S]*?<a[^>]*href="([^"]+)"[^>]*>([\s\S]*?)<\/a>/g;
        const snippetRe = /class="result__snippet"[^>]*>([\s\S]*?)<\/div>/g;
        const titles: Array<{ link: string; title: string }> = [];
        let m: RegExpExecArray | null;
        while ((m = titleRe.exec(body)) && titles.length < 8) {
          titles.push({ link: m[1], title: m[2].replace(/<[^>]+>/g, "").trim() });
        }
        const snippets: string[] = [];
        while ((m = snippetRe.exec(body)) && snippets.length < 8) {
          snippets.push(m[1].replace(/<[^>]+>/g, "").trim());
        }
        if (titles.length === 0) {
          return {
            content: [{ type: "text", text: "No results found" }],
            details: {},
          };
        }
        const out = titles
          .map((t, i) => `**${t.title}**\n${t.link}\n${snippets[i] ?? ""}`)
          .join("\n\n");
        return { content: [{ type: "text", text: out }], details: {} };
      } catch (e) {
        return {
          content: [{ type: "text", text: `Error: ${(e as Error).message}` }],
          details: {},
          isError: true,
        };
      }
    },
  });
}
