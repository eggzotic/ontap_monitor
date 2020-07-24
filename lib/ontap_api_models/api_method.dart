//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
// don't change the order of these, or insert new entries! Append only
import 'package:rest_client/rest_client.dart';

enum ApiMethod {
  get,
  post,
  patch,
  delete,
}

//
extension ApiMethodMembers on ApiMethod {
  String get name => toString().split('.').last.toUpperCase();

  RequestMethod get requestMethod => const {
        ApiMethod.get: RequestMethod.get,
        ApiMethod.post: RequestMethod.post,
        ApiMethod.patch: RequestMethod.patch,
        ApiMethod.delete: RequestMethod.delete,
      }[this];

  static ApiMethod fromIndex(int index) =>
      ApiMethod.values.firstWhere((value) => value.index == index);
  static ApiMethod fromName(String name) =>
      ApiMethod.values.firstWhere((value) => value.name == name);
}
