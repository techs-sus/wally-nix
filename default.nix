{
  lib,
  stdenv,
  wallySource,
  rustPlatform,
  pkgs,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "wally";
  version = wallySource.rev;

  src = wallySource;

  useFetchCargoVendor = true;
  cargoHash = "sha256-T/JT/f+8Nb2ULjIpSJsVtZ63j3hHY6Cvfd5EvTtzpXY=";

  nativeBuildInputs = [
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.openssl
  ];

  cargoBuildFlags = "--package wally";

  meta = {
    description = "Wally is a modern package manager for Roblox projects inspired by Cargo";
    homepage = "https://github.com/UpliftGames/wally";
    license = lib.licenses.mpl20;
    maintainers = [ ];
    platforms = lib.platforms.unix;
    mainProgram = "wally";
  };
}
