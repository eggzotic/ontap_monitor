class ApiOntapStorageShelfCable {
  ApiOntapStorageShelfCable({
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
      ApiOntapStorageShelfCable(
        identifier: json["identifier"],
        length: json["length"],
        partNumber: json["part_number"],
        serialNumber: json["serial_number"],
      );

  Map<String, dynamic> get toMap => {
        "identifier": identifier,
        "length": length,
        "part_number": partNumber,
        "serial_number": serialNumber,
      };
}
