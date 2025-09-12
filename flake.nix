{
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          cfg = {
            user = "avisek";
            displayName = "Avisek Das";
            email = "avisekdas555@gmail.com";
          };
        };
        modules = [
          {networking.hostName = "nixos";}
          {time.timeZone = "Asia/Kolkata";}
          ./system
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maccel.url = "github:Gnarus-G/maccel";
  };
}
