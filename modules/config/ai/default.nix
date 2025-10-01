{
  flake.homeModules.ai =
    { inputs, pkgs, ... }:
    {
      home.packages = with inputs; [
        nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.amp
        nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
        nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
        nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.codex
        nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.cursor-agent
        nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.gemini-cli
        nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.qwen-code
      ];

      home.file.".claude/CLAUDE.md".source = ./CLAUDE.md;
      home.file.".claude/agents".source = ./agents;

      xdg.desktopEntries.claude-desktop = {
        name = "Claude Desktop";
        comment = "AI Assistant by Anthropic";
        exec = "claude-desktop";
        icon = "claude-desktop";
        terminal = false;
        categories = [
          "Development"
          "Utility"
        ];
        startupNotify = true;
      };

      programs.fish.shellAbbrs = {
        codex = {
          position = "command";
          setCursor = true;
          expansion = "codex --search --full-auto";
        };
        cc = {
          position = "command";
          setCursor = true;
          expansion = "claude -p \"%\"";
        };
        ccyolo = {
          position = "command";
          setCursor = true;
          expansion = "claude --dangerously-skip-permissions";
        };
      };
    };
}
