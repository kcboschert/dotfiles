import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execSync } from "child_process";

/**
 * Appends the current date and operating system to the system prompt at the start of every agent turn.
 */
export default function (pi: ExtensionAPI) {
  pi.on("before_agent_start", async (event, ctx) => {
    try {
      const date = execSync('date +"%A, %B %d, %Y"').toString().trim();
      const os = execSync('uname -s').toString().trim();
      return {
        systemPrompt: `${event.systemPrompt}

Today's Date: ${date}
Operating System: ${os}`,
      };
    } catch (e) {
      // Fallback to current implementation if commands fail
      const timeZone = (ctx as any).timezone || Intl.DateTimeFormat().resolvedOptions().timeZone;
      const date = new Date().toLocaleDateString('en-US', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        timeZone: timeZone,
      });
      const os = process.platform;

      return {
        systemPrompt: `${event.systemPrompt}

Today's Date: ${date}
Operating System: ${os}`,
      };
    }
  });
}
