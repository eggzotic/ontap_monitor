//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageShelfPortRemote {
  ApiOntapStorageShelfPortRemote({
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

  factory ApiOntapStorageShelfPortRemote.fromMap(
          Map<String, dynamic> json) =>
      ApiOntapStorageShelfPortRemote(
        chassis: json["chassis"],
        macAddress: json["mac_address"],
        phy: json["phy"],
        port: json["port"],
        wwn: json["wwn"],
      );

  Map<String, dynamic> get toMap => {
        "chassis": chassis,
        "mac_address": macAddress,
        "phy": phy,
        "port": port,
        "wwn": wwn,
      };
}
