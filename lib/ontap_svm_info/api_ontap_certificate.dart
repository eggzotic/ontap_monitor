//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//

class ApiOntapCertificate {
  ApiOntapCertificate({
    this.uuid,
  });

  final String uuid;

  factory ApiOntapCertificate.fromMap(Map<String, dynamic> json) =>
      ApiOntapCertificate(
        uuid: json["uuid"],
      );

  Map<String, dynamic> get toMap => {
        "uuid": uuid,
      };
}