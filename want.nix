{

  hello = {
    _type = "attrs/derivation";
    defaultOutput = "out";
    outputs = {
      out = "/nix/store/...";
      dev = "/nix/store/...";
    };
  };
  pkgs = {
    _type = "blacklist/recursion";
    recursiveTo = [ ];
  };
  foo = {
    _type = "fail";
  };
  bar = {
    _type = "function";
    args = {
      foo = true;
      bar = false;
    };
    # variadic = true;
  };
  qux = {
    _type = "attrs";
  };

  lux = {
    _type = "int";
  };

}
