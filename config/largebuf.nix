{
  # Adapted from AstroNvim and Reddit comment
  # https://github.com/AstroNvim/astrocore/blob/v1.5.0/lua/astrocore/init.lua#L473-L486
  # https://www.reddit.com/r/neovim/comments/z85s1l/comment/iyfrgvb/
  autoGroups.large_buffer_detector = { };
  autoCmd = [
    {
      desc = "Handle large buffers";
      event = "BufRead";
      group = "large_buffer_detector";

      callback.__raw = ''
        function(args)
          if vim.b.large_buf then
            vim.cmd("syntax off")
            vim.cmd(("TSBufDisable %s"):format(args.buf))
            vim.cmd("LspStop")
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.spell = false
          end
        end
      '';
    }
  ];
}
