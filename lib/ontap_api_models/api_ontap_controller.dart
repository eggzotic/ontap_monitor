//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapController {
  ApiOntapController._private({this.overTemperature});
  //
  final String overTemperature;
  //
  factory ApiOntapController.fromMap(Map<String, dynamic> json) => json != null
      ? ApiOntapController._private(overTemperature: json["over_temperature"])
      : null;
  Map<String, dynamic> get toMap => {
        "over_temperature": overTemperature,
      };
}
