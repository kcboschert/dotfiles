local jdtls_dir = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/")
local lombok_path = jdtls_dir .. "lombok.jar"

local opts = {
  cmd = { jdtls_dir .. "bin/jdtls", "--jvm-arg=-javaagent:" .. lombok_path },
  settings = {
    java = {
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
        },
      },
      referencesCodeLens = {
        enabled = true,
      },
    },
    configuration = {
      runtimes = {
        {
          name = "JavaSE-1.8",
          path = "/Library/Java/JavaVirtualMachines/JDK-1.8.351_zulu_v6/Contents/Home",
        },
        {
          name = "JavaSE-11",
          path = "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home",
        },
        {
          name = "JavaSE-17",
          path = "/Library/Java/JavaVirtualMachines/JDK-17.0.8_zulu_v2/Contents/Home",
        },
        {
          name = "JavaSE-21",
          path = "/Library/Java/JavaVirtualMachines/openjdk-21.jdk/Contents/Home",
        },
      },
    },
  },
}
if os.getenv("JAVA_HOME") ~= nil then
  local java_path = "/Library/Java/JavaVirtualMachines/openjdk-21.jdk/Contents/Home/bin/java"
  local equinox_launcher_path = vim.fn.globpath(jdtls_dir .. "plugins", "org.eclipse.equinox.launcher_*.jar")
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = vim.fn.expand("$HOME/.workspace/" .. project_name)

  opts.cmd = {
    java_path,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. lombok_path,
    -- "-Xlog::file=" .. vim.fn.expand("$HOME/.java_jdtls.log"), "-verbose",

    "-jar", equinox_launcher_path,
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    -- Must point to the
    -- eclipse.jdt.ls installation

    "-configuration", jdtls_dir .. "config_mac",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- See `data directory configuration` section in the README
    "-data", workspace_dir,
  }
end

return {
  "mfussenegger/nvim-jdtls",
  opts = opts,
}
