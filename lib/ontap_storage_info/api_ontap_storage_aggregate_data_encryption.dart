//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageAggregateDataEncryption {
  ApiOntapStorageAggregateDataEncryption._private({
    this.softwareEncryptionEnabled,
    this.driveProtectionEnabled,
  });

  final bool softwareEncryptionEnabled;
  final bool driveProtectionEnabled;

  factory ApiOntapStorageAggregateDataEncryption.fromMap(
          Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageAggregateDataEncryption._private(
              softwareEncryptionEnabled: json["software_encryption_enabled"],
              driveProtectionEnabled: json["drive_protection_enabled"],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "software_encryption_enabled": softwareEncryptionEnabled,
        "drive_protection_enabled": driveProtectionEnabled,
      };
}
