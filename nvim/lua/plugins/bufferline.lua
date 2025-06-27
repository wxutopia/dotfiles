return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            -- text = function()
            --   return vim.fn.getcwd()
            -- end,
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
            separator = false,
          },
        },
      },
    })
  end,
}
