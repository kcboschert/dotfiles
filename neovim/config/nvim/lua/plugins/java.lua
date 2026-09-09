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
          path = vim.fn.expand("$HOME/.asdf/installs/java/openjdk-11.0.2/bin/java"),
        },
        {
          name = "JavaSE-17",
          path = vim.fn.expand("$HOME/.asdf/installs/java/openjdk-17.0.2/bin/java"),
        },
        {
          name = "JavaSE-21",
          path = vim.fn.expand("$HOME/.asdf/installs/java/openjdk-21.0.2/bin/java"),
        },
      },
    },
  },
}

return {
  "mfussenegger/nvim-jdtls",
  opts = opts,
}
