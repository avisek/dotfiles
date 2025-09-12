{inputs, ...}: {
  imports = [
    inputs.maccel.nixosModules.default
  ];

  hardware.maccel = {
    enable = true;
    enableCli = true;

    parameters = {
      sensMultiplier = 1.0;
      yxRatio = 1.25;
      inputDpi = 1000.0;
      angleRotation = 0.0;

      mode = "synchronous";
      gamma = 1.0;
      smooth = 0.5;
      motivity = 2.5;
      syncSpeed = 10.0;
    };
  };

  users.groups.maccel.members = ["avisek"];
}
