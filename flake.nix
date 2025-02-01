{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # if the source code isnt yours, you could import it here
    # and then pass it as an argument to callPackage below
    wallySource = {
      flake = false;
      url = "github:UpliftGames/wally";
    };
  };
  outputs = {self, nixpkgs, ...}@inputs: let
    forAllSys = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
  in {
    packages = forAllSys (system: let
      pkgs = import nixpkgs { inherit system; };
      wally = pkgs.callPackage ./. {
        inherit (inputs) wallySource;
        pkgs = import nixpkgs { inherit system; };
      };
    in {
      default = wally;
    });
  };
}
