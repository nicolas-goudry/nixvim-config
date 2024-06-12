{ lib, ... }:

let
  definitions = lib.attrNames (
    lib.filterAttrs
      (filename: kind:
        filename != "default.nix"
        && (lib.substring 0 1 filename) != "_"
        && (kind == "regular" || kind == "directory")
      )
      (builtins.readDir ./.)
  );
in
lib.mkMerge (map (file: import ./${file}) definitions)
