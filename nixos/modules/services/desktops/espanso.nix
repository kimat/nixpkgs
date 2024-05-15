{ config, lib, pkgs, ... }:

with lib;
let cfg = config.services.espanso;
in {
  meta = { maintainers = with lib.maintainers; [ numkem ]; };

  options = {
    services.espanso = {
      enable = options.mkEnableOption (lib.mdDoc "Espanso");
      package = mkOption {
        type = types.package;
        default = pkgs.espanso;
        defaultText = literalExpression "pkgs.espanso";
        description = mdDoc "The espanso package to use.";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.espanso = {
      description = "Espanso daemon";
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/espanso daemon";
        Restart = "on-failure";
      };
      wantedBy = [ "default.target" ];
    };

    environment.systemPackages = [ cfg.package ];
  };
}
