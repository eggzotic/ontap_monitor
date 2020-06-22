//
// don't change the order of these, or insert new entries! Append only
import 'package:rest_client/rest_client.dart';

enum _ApiMethod {
  get,
  post,
  patch,
  delete,
}

//
// a class to act like an enhanced enum
class ApiMethod {
  final _ApiMethod _method;
  const ApiMethod._private(this._method);
  static const get = ApiMethod._private(_ApiMethod.get);
  static const post = ApiMethod._private(_ApiMethod.post);
  static const patch = ApiMethod._private(_ApiMethod.patch);
  static const delete = ApiMethod._private(_ApiMethod.delete);

  static final values = [
    get,
    post,
    patch,
    delete,
  ];

  int get index => _method.index;

  static const Map<ApiMethod, String> _nameMap = {
    get: 'GET',
    post: 'POST',
    patch: 'PATCH',
    delete: 'DELETE',
  };

  String get name => _nameMap[this];

  RequestMethod get requestMethod {
    switch (this) {
      case get:
        return RequestMethod.get;
      case post:
        return RequestMethod.post;
      case patch:
        return RequestMethod.patch;
      case delete:
        return RequestMethod.delete;
      default:
        return RequestMethod.get;
    }
  }

  factory ApiMethod.fromIndex(int index) =>
      values.firstWhere((value) => value.index == index);
}
