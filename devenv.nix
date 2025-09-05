{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
    checkmake
    lua54Packages.luacheck
    nixfmt-classic
    powershell
    stylua
  ];

  # https://devenv.sh/languages/
  languages.lua.enable = true;
  languages.shell.enable = true;

  # https://devenv.sh/tasks/
  tasks = {
    "lint:run".exec = ''
      checkmake Makefile
      nixfmt devenv.nix
      luacheck nvim/
      pwsh -Command "Install-Module -Name PSScriptAnalyzer -Force"
      pwsh -Command "Invoke-ScriptAnalyzer -Path winfetch -Recurse"
      git ls-files --cached --others --exclude-standard '*.sh' | xargs shellcheck
      git ls-files --cached --others --exclude-standard '*.sh' | xargs shfmt -w
      stylua nvim/'';
  };

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    checkmake.enable = true;
    luacheck.enable = true;
    mdformat.enable = true;
    nixfmt-classic.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;
    stylua.enable = true;
    trim-trailing-whitespace.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
