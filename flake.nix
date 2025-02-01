{
  nixConfig = {
    # Adapted From: https://github.com/divnix/digga/blob/main/examples/devos/flake.nix#L4
    extra-substituters = "https://techs-sus-wally-nix.cachix.org";
    extra-trusted-public-keys = "techs-sus-wally-nix.cachix.org-1:hOye+Fj1heELMgDJOzDoQnFLsQA/kVN0ZVRnZmsAyB4=";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    wallySource = {
      flake = false;
      url = "github:UpliftGames/wally";
    };
  };

  outputs = {self, nixpkgs, ...}@inputs: let
    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
  in {
    packages = forAllSystems (system: let
      pkgs = import nixpkgs { inherit system; };
    in {
      default = pkgs.callPackage ./. {
        inherit (inputs) wallySource;
        inherit pkgs;
      };
    });
  };
}
