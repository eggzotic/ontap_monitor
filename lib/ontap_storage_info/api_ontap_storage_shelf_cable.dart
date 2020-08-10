//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageShelfCable {
  ApiOntapStorageShelfCable._private({
    this.identifier,
    this.length,
    this.partNumber,
    this.serialNumber,
  });

  final String identifier;
  final String length;
  final String partNumber;
  final String serialNumber;

  factory ApiOntapStorageShelfCable.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageShelfCable._private(
              identifier: json["identifier"],
              length: json["length"],
              partNumber: json["part_number"],
              serialNumber: json["serial_number"],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "identifier": identifier,
        "length": length,
        "part_number": partNumber,
        "serial_number": serialNumber,
      };
}
