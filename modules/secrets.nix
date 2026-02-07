{ config, ... }: {
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "/Users/justin/.config/sops/age/keys.txt";

    secrets = {
      onepassword_signing_key = {
        owner = "justin";
      };
      bartender_license = {
        owner = "justin";
      };
    };
  };
}
