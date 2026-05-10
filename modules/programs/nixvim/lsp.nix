{
  programs.nixvim.plugins.lsp =
    let
      localLsp = {
        enable = true;
        package = null;
      };
    in
    {
      enable = true;
      capabilities = ''
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      '';
      servers = {
        nixd.enable = true;
        clangd = localLsp;
        gopls = localLsp;
        rust_analyzer = localLsp // {
          installCargo = false;
          installRustc = false;
          installRustfmt = false;
        };
        ts_ls = localLsp;
        vue_ls = localLsp // {
          tslsIntegration = false;
        };
        html = localLsp;
        cssls = localLsp;
        jsonls = localLsp;
        pyright = localLsp;
      };
    };
}
