vim.opt_local.tabstop=4
vim.opt_local.shiftwidth=4
vim.opt_local.softtabstop=4

local java_17_jdk_path = '/Library/Java/JavaVirtualMachines/jdk-17.0.4.jdk/Contents/Home/bin/java'
local jdtls_dir = vim.fn.expand('$HOME/.local/share/nvim/mason/packages/jdtls/')
-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('$HOME/.workspace/' .. project_name)
local lombok_path = jdtls_dir .. 'lombok.jar'
local equinox_launcher_path = vim.fn.globpath(jdtls_dir .. 'plugins', 'org.eclipse.equinox.launcher_*.jar')

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    java_17_jdk_path, -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_path,

    -- 💀
    '-jar', equinox_launcher_path,
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         -- Must point to the
         -- eclipse.jdt.ls installation


    -- 💀
    '-configuration', jdtls_dir .. 'config_mac',
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_dir,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  -- Plugin author's config is here: https://github.com/mfussenegger/dotfiles/blob/c2c5922e6562d3e762f5004ad9cd1d7bc277fca2/vim/.config/nvim/ftplugin/java.lua#L1-L91
  settings = {
    java = {
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
        }
      },
      inlayHints = {
        parameterNames = { enabled = "all"}
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      format = {
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
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

require('jdtls').start_or_attach(config)
