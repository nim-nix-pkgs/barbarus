{
  description = ''A simple extensible i18n engine.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."barbarus-master".dir   = "master";
  inputs."barbarus-master".owner = "nim-nix-pkgs";
  inputs."barbarus-master".ref   = "master";
  inputs."barbarus-master".repo  = "barbarus";
  inputs."barbarus-master".type  = "github";
  inputs."barbarus-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."barbarus-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}