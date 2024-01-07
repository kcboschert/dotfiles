local opts = {
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
          path = "/Library/Java/JavaVirtualMachines/zulu-sa-1.8.0_232.jdk/Contents/Home",
        },
        {
          name = "JavaSE-11",
          path = "/Library/Java/JavaVirtualMachines/zulu-sa-11.0.10.jdk/Contents/Home",
        },
        {
          name = "JavaSE-17",
          path = "/Library/Java/JavaVirtualMachines/jdk-17.0.4.jdk/Contents/Home",
        },
      },
    },
  },
}
if os.getenv("JAVA_HOME") ~= nil then
  local java_path = "/Library/Java/JavaVirtualMachines/jdk-17.0.4.jdk/Contents/Home/bin/java"
  local jdtls_dir = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/")
  local lombok_path = jdtls_dir .. "lombok.jar"
  local equinox_launcher_path = vim.fn.globpath(jdtls_dir .. "plugins", "org.eclipse.equinox.launcher_*.jar")
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = vim.fn.expand("$HOME/.workspace/" .. project_name)

  opts["cmd"] = {
    java_path,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dosgi.checkConfiguration=true",
    "-Dosgi.sharedConfiguration.area=" .. jdtls_dir .. "config_mac",
    "-Dosgi.sharedConfiguration.area.readOnly=true",
    "-Dosgi.configuration.cascaded=true",
    "-Xms1G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. lombok_path,

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