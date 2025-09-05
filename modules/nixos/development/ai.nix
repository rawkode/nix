_: {
  flake.nixosModules.ai = _: {
    # Codebase Indexing for AI Agents
    services.qdrant.enable = true;
  };
}
