//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class OntapApiError {
  final String message;
  final String code;
  final String target;
  //
  OntapApiError({
    this.message,
    this.code,
    this.target,
  });
  //
  factory OntapApiError.fromMap(Map<String, dynamic> json) {
    final String message = json['message'];
    final String code = json['code'];
    final String target = json['target'];
    return OntapApiError(message: message, code: code, target: target);
  }
}
