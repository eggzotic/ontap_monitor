class ApiOntapStorageAggregateDataEncryption {
  ApiOntapStorageAggregateDataEncryption({
    this.softwareEncryptionEnabled,
    this.driveProtectionEnabled,
  });

  final bool softwareEncryptionEnabled;
  final bool driveProtectionEnabled;

  factory ApiOntapStorageAggregateDataEncryption.fromMap(
          Map<String, dynamic> json) =>
      ApiOntapStorageAggregateDataEncryption(
        softwareEncryptionEnabled: json["software_encryption_enabled"],
        driveProtectionEnabled: json["drive_protection_enabled"],
      );

  Map<String, dynamic> get toMap => {
        "software_encryption_enabled": softwareEncryptionEnabled,
        "drive_protection_enabled": driveProtectionEnabled,
      };
}
