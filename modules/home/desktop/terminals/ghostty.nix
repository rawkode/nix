{
  flake.homeModules.ghostty =
    {
      inputs,
      pkgs,
      config,
      lib,
      ...
    }:
    let
      leader = "ctrl+comma";
    in
    {
      stylix.targets.ghostty.enable = false;
      programs.ghostty = {
        enable = true;
        package = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;

        enableBashIntegration = false;
        enableFishIntegration = false;

        clearDefaultKeybinds = true;

        # All options are documented at
        # https://ghostty.org/docs/config/reference
        settings = {
          theme = "dark:Rose Pine Moon,light:Rose Pine Dawn";

          auto-update = "off";

          shell-integration = "detect";

          mouse-hide-while-typing = true;

          clipboard-read = "allow";
          clipboard-write = "allow";
          copy-on-select = "clipboard";
          clipboard-trim-trailing-spaces = true;
          clipboard-paste-protection = true;

          confirm-close-surface = false;

          focus-follows-mouse = true;

          # Split visibility improvements
          split-divider-color = lib.mkDefault (with config.lib.stylix.colors.withHashtag; base0D);
          unfocused-split-fill = lib.mkDefault (with config.lib.stylix.colors.withHashtag; base0D);
          unfocused-split-opacity = 0.5;

          # Performance optimizations
          gtk-single-instance = true;
          gtk-titlebar = true;

          window-decoration = true;
          window-colorspace = "display-p3";
          window-padding-x = 16;
          window-padding-y = 16;
          window-padding-balance = true;

          keybind = [
            "ctrl+space=toggle_command_palette"

            "shift+insert=paste_from_clipboard"
            "ctrl+shift+v=paste_from_clipboard"

            "${leader}>r=reload_config"

            "${leader}>i=inspector:toggle"

            "${leader}>t=new_tab"
            "${leader}>q=close_tab"
            "ctrl+page_up=previous_tab"
            "ctrl+page_down=next_tab"

            "ctrl+plus=increase_font_size:1"
            "ctrl+minus=decrease_font_size:1"
            "ctrl+0=reset_font_size"

            "ctrl+shift+p=toggle_command_palette"

            "${leader}>z=toggle_split_zoom"
            "${leader}>x=close_surface"

            "alt+shift+backslash=new_split:right"
            "alt+backslash=new_split:down"

            "alt+arrow_down=goto_split:down"
            "alt+arrow_up=goto_split:up"
            "alt+arrow_left=goto_split:left"
            "alt+arrow_right=goto_split:right"

            "shift+enter=text:\n"
          ];
        };
      };
    };
}
