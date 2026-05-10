{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        output = [ "eDP-1" "Virtual-1" ];
        layer = "top";
        position = "top";
        spacing = 0;
        "margin-top" = 4;
        "margin-left" = 0;
        "margin-right" = 4;
        "margin-bottom" = 0;
        height = 36;

        "modules-left" = [
          "hyprland/workspaces"
        ];
        
        "modules-center" = [
          "tray"
        ];
        
        "modules-right" = [
          "pulseaudio"
          "network"
          "memory"
          "cpu"
          "battery"
          "clock"
          "custom/power"
          "custom/notification"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          "persistent-workspaces" = {
            "*" = 5;
          };
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          "format-icons" = {};
        };

        tray = {
          "icon-size" = 21;
          spacing = 10;
        };

        clock = {
          interval = 1;
          format = " {:%H:%M}";
          "format-alt" = " {:%m-%d %H:%M:%S}";
          timezone = "Asia/Shanghai";
          "tooltip-format" = "{calendar}";
          calendar = {
            mode = "month";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            format = {
              months = "<span color='#ffead3'>{}</span>";
              days = "<span color='#ecc6d9'>{}</span>";
              weekdays = "<span color='#ffcc66'>{}</span>";
              today = "<span color='#ff6699'><u>{}</u></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };

        cpu = {
          interval = 1;
          format = " {usage:1}%";
          tooltip = true;
        };

        memory = {
          interval = 1;
          format = "{used:0.1f}G";
          tooltip = true;
          "tooltip-format" = " RAM: {used:0.2f}G / {total:0.2f}G\nSwap: {swapUsed:0.2f}G / {swapTotal:0.2f}G";
        };

        network = {
          interval = 1;
          "format-wifi" = " {signalStrength}%";
          "format-ethernet" = " {ifname}";
          "format-linked" = " No IP ({ifname})";
          "format-disconnected" = " Disconnected";
          "tooltip-format" = "{ifname}: {ipaddr}/{cidr}, Gateway: {gwaddr}";
          "format-alt" = " {essid}";
        };

        pulseaudio = {
          "scroll-step" = 5;
          format = "{icon} {volume:2}%";
          "format-muted" = "";
          "format-bluetooth" = "{icon} {volume}%";
          "format-bluetooth-muted" = " ";
          "format-icons" = {
            default = [
              ""
              ""
              ""
            ];
          };
          "on-click-right" = "pavucontrol";
          "ignored-sinks" = [
            "AudioRelay Virtual Sink"
            "Recorder Sink"
          ];
        };

        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          "format-icons" = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        "custom/power" = {
          format = "⏻";
          "on-click" = "wlogout";
          tooltip = false;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          "format-icons" = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          escape = true;
        };
      };
    };
  };
  
	xdg.configFile."waybar/style.css".source = ./style.css;
}