{
  description = "An open-source C++ library developed and used at Facebook.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
      in
      {
        defaultPackage = pkgs.stdenv.mkDerivation {
          name = "folly";
          src = ./.;
          nativeBuildInputs = with pkgs; [
            cmake
            pkg-config
          ];
          buildInputs = with pkgs; [
            boost
            double-conversion
            fmt
            gflags
            glog
            jemalloc
            libevent
            libiberty
            libunwind
            lz4
            openssl
            xz
            zlib
          ];
          cmakeFlags = [ "-DBUILD_SHARED_LIBS=ON" ];
          enableParallelBuilding = true;
        };
      });
}
