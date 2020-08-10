//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class OntapApiError {
  final String message;
  final String code;
  final String target;
  //
  OntapApiError._private({
    this.message,
    this.code,
    this.target,
  });
  //
  factory OntapApiError.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return OntapApiError._private(
      message: json['message'],
      code: json['code'],
      target: json['target'],
    );
  }
}
