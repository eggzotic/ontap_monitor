//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageShelfPortRemote {
  ApiOntapStorageShelfPortRemote._private({
    this.chassis,
    this.macAddress,
    this.phy,
    this.port,
    this.wwn,
  });

  final String chassis;
  final String macAddress;
  final String phy;
  final String port;
  final String wwn;

  factory ApiOntapStorageShelfPortRemote.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageShelfPortRemote._private(
              chassis: json["chassis"],
              macAddress: json["mac_address"],
              phy: json["phy"],
              port: json["port"],
              wwn: json["wwn"],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "chassis": chassis,
        "mac_address": macAddress,
        "phy": phy,
        "port": port,
        "wwn": wwn,
      };
}
