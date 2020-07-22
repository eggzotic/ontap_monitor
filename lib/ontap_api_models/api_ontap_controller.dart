//
class ApiOntapController {
  ApiOntapController({this.overTemperature});
  final String overTemperature;
  factory ApiOntapController.fromMap(Map<String, dynamic> json) =>
      ApiOntapController(
        overTemperature: json["over_temperature"],
      );
  Map<String, dynamic> get toMap => {
        "over_temperature": overTemperature,
      };
}
