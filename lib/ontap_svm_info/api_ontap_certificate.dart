//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//

class ApiOntapCertificate {
  ApiOntapCertificate._private({this.uuid});

  final String uuid;

  factory ApiOntapCertificate.fromMap(Map<String, dynamic> json) =>
      json != null ? ApiOntapCertificate._private(uuid: json["uuid"]) : null;

  Map<String, dynamic> get toMap => {
        "uuid": uuid,
      };
}
