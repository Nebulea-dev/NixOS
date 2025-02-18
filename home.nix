{ config, lib, pkgs, ... }:

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

      # Transform dconf dump to nix config
      dconf2nix

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
      ${pkgs.chezmoi}/bin/chezmoi init --apply Nebulea-dev
    '';

    # This needs to actually be set to your username
    username = "nixian";
    homeDirectory = "/home/nixian";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "23.11";
  };

  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file://" + ./assets/wallpaper.jpg;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {                                                                                            
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];                                       
    };                                                                                                                                            
                                                                                                                                                  
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {                                                                 
      binding = "<Control><Alt>t";                                                                                                                
      command = "gnome-terminal";                                                                                                                 
      name = "open terminal";                                                                                                                     
    };  
  };

  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;

    profile.b1dcc9dd-5262-4d8d-a863-c897e6d979b9 = {
      default = true;
      visibleName = "nix-terminal-conf";

      showScrollbar = true;
      font = "RobotoMono Nerd Font 16";
      
      colors = {
        palette = [
          "#36283d"
          "#71ADE9"
          "#AB8CAE"
          "#9EA0D3"
          "#8BB8E9"
          "#E1B4CE"
          "#cedaeb"
          "#9098a4"
          "#71ADE9"
          "#AB8CAE"
          "#E59DB1"
          "#9EA0D3"
          "#8BB8E9"
          "#E1B4CE"
          "#cedaeb"
          "#FFFEFE"
        ];

        backgroundColor = "#36283d";
        foregroundColor = "#c7ccd1";
      };
    };
  };
}

