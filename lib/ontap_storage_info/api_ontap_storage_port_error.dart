//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStoragePortError {
  ApiOntapStoragePortError({
    this.correctiveAction,
    this.message,
  });

  final String correctiveAction;
  final String message;

  factory ApiOntapStoragePortError.fromMap(Map<String, dynamic> json) =>
      ApiOntapStoragePortError(
        correctiveAction: json["corrective_action"],
        message: json["message"],
      );

  Map<String, dynamic> get toMap => {
        "corrective_action": correctiveAction,
        "message": message,
      };
}
