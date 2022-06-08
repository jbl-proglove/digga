{
  # TODO try xdg.configFile."alacritty/alacritty.yml".source = ../../configs/terminal/alacritty.yml;
  programs.alacritty = {
    enable = true;
    settings = {

      ########################
      # environment settings #
      ########################
      env = {
        TERM = "xterm-256color";
        # fixes issue with differing font sizes on laptop and external
        # monitors
        WINIT_X11_SCALE_FACTOR = "1";
      };

      ########################
      # window settings      #
      ########################
      window = {
        title = "Alacritty";
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
        padding = {
          x = 4;
          y = 4;
        };
        dynamic_padding = false;
        decorations = "None";
      };

      ########################
      # font settings        #
      ########################
      font = {
        use_thin_strokes = true;
        normal = {
          family = "FuraMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FuraMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FuraMono Nerd Font";
          style = "Italic";
        };
        size = 14.0;
      };

      ########################
      # cursor settings      #
      ########################
      cursor.style = "Block";

      ########################
      # bell settings        #
      ########################
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "#aa8888";
      };
      selection.save_to_clipboard = true;

      ########################
      # color settings       #
      ########################
      colors = {


        primary = {
          background = "0x2e3440";
          foreground = "0xd8dee9";
          #dim_foreground = "0xa5abb6";
        };
        cursor = {
          text = "0x2e3440";
          cursor = "0xd8dee9";
        };
        vi_mode_cursor = {
          text = "0x2e3440";
          cursor = "0xd8dee9";
        };
        selection = {
          text = "CellForeground";
          background = "0x4c566a";
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = "0x88c0d0";
          };
          bar = {
            background = "0x434c5e";
            foreground = "0xd8dee9";
          };
        };
        normal = {
          black = "0x3b4252";
          red = "0xbf616a";
          green = "0xa3be8c";
          yellow = "0xebcb8b";
          blue = "0x81a1c1";
          magenta = "0xb48ead";
          cyan = "0x88c0d0";
          white = "0xe5e9f0";
        };
        bright = {
          black = "0x4c566a";
          red = "0xbf616a";
          green = "0xa3be8c";
          yellow = "0xebcb8b";
          blue = "0x81a1c1";
          magenta = "0xb48ead";
          cyan = "0x8fbcbb";
          white = "0xeceff4";
        };
        #        dim = {
        #          black = "0x373e4d";
        #          red = "0x94545d";
        #          green = "0x809575";
        #          yellow = "0xb29e75";
        #          blue = "0x68809a";
        #          magenta = "0x8c738c";
        #          cyan = "0x6d96a5";
        #          white = "0xaeb3bb";
        #        };
        # molokai?
        #        primary = {
        #          background = "0x151515";
        #          foreground = "0xeaeaea";
        #        };
        #        cursor = {
        #          text = "0x000000";
        #          cursor = "0xffffff";
        #        };
        #        normal = {
        #          black = "0x121212";
        #          red = "0xfa2573";
        #          green = "0x9cff00";
        #          yellow = "0xdfd460";
        #          blue = "0x1080d0";
        #          magenta = "0x8700ff";
        #          cyan = "0x43a8d0";
        #          white = "0xbbbbbb";
        #        };
        #        bright = {
        #          black = "0x555555";
        #          red = "0xf6669d";
        #          green = "0xb1e05f";
        #          yellow = "0xfff26d";
        #          blue = "0x00afff";
        #          magenta = "0xaf87ff";
        #          cyan = "0x51ceff";
        #          white = "0xffffff";
        #        };
      };
      # dracula
      # Default colors
      #        primary = {
      #          background = "0x282a36";
      #          foreground = "0xdadbd7";
      #        };
      #
      #        cursor = {
      #          text = "0x282a36";
      #          cursor = "0xbd93f9";
      #        };
      #
      #        selection = {
      #          text = "0x282a36";
      #          background = "0x6272a4";
      #        };
      #
      #        # Normal colors
      #        normal = {
      #          black = "0x63656c";
      #          red = "0xff5555";
      #          green = "0x50fa7b";
      #          yellow = "0xf1fa8c";
      #          blue = "0x6272a4";
      #          magenta = "0xff79c6";
      #          cyan = "0x8be9fd";
      #          white = "0xdadbd7";
      #        };
      #
      #        # Bright colors
      #        bright = {
      #          black = "0x818287";
      #          red = "0xfe7674";
      #          green = "0x72fa93";
      #          yellow = "0xf2faa0";
      #          blue = "0x808db4";
      #          magenta = "0xfe92cf";
      #          cyan = "0xa1ecfb";
      #          white = "0xf8f8f2";
      #        };
      #
      #        # Dim colors
      #        dim = {
      #          black = "0x464751";
      #          red = "0xd44c4f";
      #          green = "0x48d06d";
      #          yellow = "0xc9d07b";
      #          blue = "0x56648e";
      #          magenta = "0xd469a9";
      #          cyan = "0x77c3d5";
      #          white = "0xbdbdbc";
      #        };
    };
  };
  #  };
}
