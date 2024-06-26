local setup = function()
  --local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  --parser_config.scala = {
  --  install_info = {
  --    -- url can be Git repo or a local directory:
  --    url = "~/Documents/js-workspace/tree-sitter-scala",
  --    --url = "https://github.com/eed3si9n/tree-sitter-scala.git",
  --    --branch = "fork-integration",
  --    files = { "src/parser.c", "src/scanner.c" },
  --    requires_generate_from_grammar = false,
  --  },
  --}
  require("nvim-treesitter.configs").setup({
    playground = { enable = true },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
    context_commentstring = { enable = true, enable_autocmd = false },
    ensure_installed = {
        "bash",
        "diff",
        "gitignore",
        "haskell",
        "haskell_persistent",
        "hocon",
        "ini",
        "json",
        "jq",
        "lua",
        "markdown",
        "markdown_inline",
        "ocaml",
        "ocaml_interface",
        "properties",
        "query",
        "regex",
        "rust",
        "scala",
        "sql",
        "tmux",
        "toml",
        "vim",
        "yaml",
    },
    -- ensure_installed = "all",
    treesitter = {
      enable = false
    },
    highlight = {
      enable = true
    },
    indent = {
      enable = true
    }
  })
end

return {
  setup = setup,
}
