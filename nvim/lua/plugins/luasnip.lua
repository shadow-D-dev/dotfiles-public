return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "mlaursen/vim-react-snippets",
  },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node

    --------------------------------------------------------------------
    -- 🧩 Load external snippet sources
    --------------------------------------------------------------------
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = vim.fn.stdpath("data") .. "/lazy/vim-react-snippets",
    })

    --------------------------------------------------------------------
    -- ✨ Helper functions
    --------------------------------------------------------------------
    -- Returns current clipboard contents
    local function clipboard()
      return vim.fn.getreg("+")
    end

    -- Create Markdown code block snippet for a given language
    local function create_code_block_snippet(lang)
      return s({
        trig = lang,
        name = "Codeblock",
        desc = lang .. " codeblock",
      }, {
        t({ "```" .. lang, "" }),
        i(1),
        t({ "", "```" }),
      })
    end

    --------------------------------------------------------------------
    -- 🪄 Markdown Snippets
    --------------------------------------------------------------------
    local languages = {
      "txt",
      "lua",
      "sql",
      "go",
      "regex",
      "bash",
      "markdown",
      "markdown_inline",
      "yaml",
      "json",
      "jsonc",
      "cpp",
      "csv",
      "java",
      "javascript",
      "python",
      "dockerfile",
      "html",
      "css",
      "templ",
      "php",
      "vim",
      "Typescript",
      "Typescriptreact",
    }

    local snippets = {}

    -- Codeblock snippets
    for _, lang in ipairs(languages) do
      table.insert(snippets, create_code_block_snippet(lang))
    end

    --------------------------------------------------------------------
    -- 🔗 Clipboard-based Markdown link snippets
    --------------------------------------------------------------------
    -- Paste clipboard contents in link section, move cursor to ()
    table.insert(
      snippets,
      s({
        trig = "linkc",
        name = "Paste clipboard as .md link",
        desc = "Paste clipboard as .md link",
      }, {
        t("["),
        i(1, "link-text"),
        t("]("),
        f(clipboard, {}),
        t(")"),
      })
    )

    -- Paste clipboard contents in link section, move cursor to (), open in new tab
    table.insert(
      snippets,
      s({
        trig = "linkex",
        name = "Paste clipboard as EXT .md link",
        desc = "Paste clipboard as EXT .md link",
      }, {
        t("["),
        i(1, "link-text"),
        t("]("),
        f(clipboard, {}),
        t('){:target="_blank"}'),
      })
    )
    --------------------------------------------------------------------
    -- ✅ Markdown TODO Snippet
    --------------------------------------------------------------------
    table.insert(
      snippets,
      s({
        trig = "to",
        name = "Markdown TODO",
        desc = "Insert a markdown task checkbox",
      }, {
        t("- [ ] "),
        i(1, "Task description"),
      })
    )
    --------------------------------------------------------------------
    -- 📝 Register snippets only for markdown & markdown.mdx
    --------------------------------------------------------------------
    ls.add_snippets("markdown", snippets)
    ls.add_snippets("markdown.mdx", snippets)
  end,
}
