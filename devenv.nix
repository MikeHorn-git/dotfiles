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

  # https://devenv.sh/scripts/
  scripts = {
    lua.exec = ''
      luacheck nvim/
      stylua nvim/'';
    build.exec = "checkmake Makefile";
    check.exec = "nixfmt devenv.nix";
    pwsh.exec = ''
      pwsh -Command "Install-Module -Name PSScriptAnalyzer -Force"
      pwsh -Command "Invoke-ScriptAnalyzer -Path winfetch -Recurse"'';
    shell.exec = ''
      git ls-files scripts/ | xargs shellcheck
      git ls-files scripts/ | xargs shfmt -w'';
  };

  # https://devenv.sh/basics/
  enterShell = ''
    echo "Available commands:"
    echo " - lua          : Lint Lua"
    echo " - make         : Lint Makefile"
    echo " - nix          : Lint Nix"
    echo " - pwsh         : Lint Powershell scripts"
    echo " - shell        : Lint Shell scripts"
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    make
  '';

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
