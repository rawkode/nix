let
  main_bar = {
    anchor_to_edges = true;
    position = "top";
    height = 16;
    start = [
      {
        type = "workspaces";
        sort = "added";
      }
    ];
    center = [
      {
        type = "focused";
        icon_size = 24;
        show_icon = true;
        show_title = false;
      }
    ];
    end = [
      {
        type = "tray";
        icon_size = 32;
      }
      {
        type = "battery";
      }
    ];
  };
in
{
  flake.homeModules.ironbar =
    { config, ... }:
    {
      programs.ironbar = {
        enable = true;
        systemd = true;

        config = {
          icon_theme = "rose-pine";

          monitors = {
            eDP-1 = main_bar;
            DP-1 = main_bar;
            DP-2 = {
              anchor_to_edges = true;
              position = "top";
              height = 16;
              start = [
                {
                  type = "workspaces";
                  sort = "added";
                }
              ];
              center = [
                {
                  type = "focused";
                  icon_size = 24;
                  show_icon = true;
                  show_title = false;
                }
              ];
              end = [ ];
            };
          };
        };
        style = ''
          * {
            font-family: "Monaspace Neon";
            font-size: 16px;
            text-shadow: 2px 2px ${config.lib.stylix.colors.withHashtag.base00};
            border: none;
            border-radius: 0;
            outline: none;
            font-weight: 500;
            background: none;
            color: ${config.lib.stylix.colors.withHashtag.base05};
          }

          .background {
            background: alpha(${config.lib.stylix.colors.withHashtag.base00}, 0.925);
          }

          .workspaces {
            padding-left: 1em;
            padding-right: 1em;
          }

          .workspaces .item {
            padding-left: 1em;
            padding-right: 1em;
          }

          .workspaces .item.focused {
            border-bottom: 2px solid ${config.lib.stylix.colors.withHashtag.base0D};
          }

          .battery  {
            padding-right: 1em;
          }

          .tray {
            padding-left: 1em;
            padding-right: 1em;
          }

          .tray .item {
            padding-left: 1em;
            padding-right: 1em;
          }
        '';
      };
    };
}
