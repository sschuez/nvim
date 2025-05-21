return {
  "atiladefreitas/dooing",
  config = function()
    require("dooing").setup({
      window = {
        width = 120,
        height = 40,
        border = "rounded",
        position = "center",
        -- 'top-right', 'top-left', 'bottom-right', 'bottom-left'
        padding = {
          top = 1,
          bottom = 1,
          left = 2,
          right = 2,
        },
      },
    })
  end,
}
