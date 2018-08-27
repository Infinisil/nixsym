let
  lib = import ./nixpkgs/lib;
  pkgs = import ./nixpkgs {};
  blacklist = let
    lisp = {
      pkgs = null;
      quicklisp-to-nix-packages = null;
    };
  in {
    lispPackages = lisp;
    quicklispPackages = lisp;
    quicklispPackagesClisp = lisp;
    quicklispPackagesSBCL = lisp;
    quicklispPackages_asdf_3_1 = lisp;
    buildPackages = null;
    pkgs = null;
    pkgsCross = null;
    pkgsMusl = null;
    pkgsi686Linux = null;
    targetPackages = null;
  };
  collect = blacklist: prefix: attrs: let
    inherit (builtins.tryEval attrs) value success;
    recurse = blacklist != null && lib.isAttrs value && ! lib.isDerivation value && value._type or "" != "option-type";
  in if ! recurse then [] else
    lib.concatMap (name: builtins.trace (lib.concatStringsSep "." (lib.reverseList ([name] ++ prefix)) + ": " + builtins.toJSON blacklist) (
      if lib.hasPrefix "_" name || (lib.length prefix != 0 && lib.elemAt prefix 0 == name) then [] else
      [ ([name] ++ prefix) ] ++ collect (blacklist.${name} or {}) ([name] ++ prefix) value.${name}
    )) (lib.attrNames value);

in

  map (list: lib.concatStringsSep "." (lib.reverseList list)) (collect blacklist [] pkgs)
