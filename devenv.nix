{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
  ];

  # https://devenv.sh/languages/
  languages.lua.enable = true;
  languages.shell.enable = true;

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    checkmake.enable = true;
    luacheck.enable = true;
    nixfmt.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;
    stylua.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
