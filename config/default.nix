{ lib, ... }:

let
  definitions = lib.attrNames (
    lib.filterAttrs
      (filename: kind:
        filename != "default.nix"
        && (kind == "regular" || kind == "directory")
      )
      (builtins.readDir ./.)
  );
in
lib.mkMerge (map (file: import ./${file}) definitions)
