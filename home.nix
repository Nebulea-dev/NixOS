{ config, inputs, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
      zsh
      tmux
      chezmoi
      starship
      eza
      bat
      oh-my-zsh
      diff-so-fancy
      cargo
      neovim
      nerdfonts
      lunarvim
      unstable.rustc
      xsel
      unzip
      ripgrep
      libgcc
      nodejs
      gccgo
      tree-sitter
      fd

      # Tree-sitter dependencies
      luajitPackages.luarocks
      python312
      zulu17
      julia_19-bin
      php
      php83Packages.composer

      # LSPs
      lua-language-server
    ];
    
    sessionPath = [
      "$HOME/.local/bin"
    ];

    activation.chezmoi = lib.hm.dag.entryAfter ["installPackages"] ''
      ${pkgs.chezmoi}/bin/chezmoi init --apply --branch NixOS Nebulea-dev
    '';

    # This needs to actually be set to your username
    username = "lea";
    homeDirectory = "/home/lea";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "23.11";
  };
}
