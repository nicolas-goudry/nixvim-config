{
  # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_options.lua#L49-L53
  g.markdown_recommended_style = 0;

  t.bufs.__raw = ''
    (function()
      if not vim.t.bufs then vim.t.bufs = vim.api.nvim_list_bufs() end
      return vim.t.bufs
    end)()
  '';
}
