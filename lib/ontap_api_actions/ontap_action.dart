import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/ontap_api_models/api_method.dart';
import 'package:uuid/uuid.dart';

//
class OntapAction with ChangeNotifier {
  static const _ontapApiPath = '/api/';
  final String _id;
  String _name;
  String _description;
  String _api;
  ApiMethod _method;
  Set<String> _parameterNames;
  //
  factory OntapAction() {
    final uuid = Uuid();
    final v4 = uuid.v4();
    return OntapAction._private(id: v4);
  }
  OntapAction._private({
    @required String id,
    String name = '',
    String description = '',
    String api = '',
    ApiMethod method = ApiMethod.get,
    Set<String> parameterNames,
  }) : _id = id {
    _name = name;
    _description = description;
    _api = api;
    _method = method;
    _parameterNames = parameterNames ?? Set<String>();
  }
  //
  Map<String, dynamic> get toMap => {
        'id': _id,
        'name': _name,
        'description': _description,
        'api': _api,
        'methodIndex': _method.index,
        'parameterNames': _parameterNames.toList(),
      };
  //
  String get asJson => json.encode(toMap);
  //
  factory OntapAction.fromMap(Map<String, dynamic> json) {
    print('OntapAction.fromMap: json = $json');
    final id = json['id'] as String;
    final name = json['name'] as String;
    final description = json['description'] as String;
    final api = json['api'] as String;
    final int methodIndex = json['methodIndex'];
    final method = ApiMethod.fromIndex(methodIndex);
    final Set<String> parameterNames = Set.from(json['parameterNames']);
    return OntapAction._private(
      id: id,
      name: name,
      description: description,
      api: api,
      method: method,
      parameterNames: parameterNames,
    );
  }
  //
  factory OntapAction.fromJson(String text) =>
      OntapAction.fromMap(json.decode(text));
  //
  bool get isValid => _name.isNotEmpty && _api.isNotEmpty;
  //
  String get id => _id;
  //
  String get name => _name;
  void setName(String newName) {
    final cName = newName.toLowerCase().trim();
    _name = cName;
    notifyListeners();
  }

  //
  String get description => _description;
  void setDescription(String newDesc) {
    final cDesc = newDesc.trim();
    _description = cDesc;
    notifyListeners();
  }

  //
  String get api => _api;
  void setApi(String newApi) {
    final cApi = newApi.toLowerCase().trim();
    _api = cApi;
    notifyListeners();
  }

  //
  ApiMethod get method => _method;
  void setMethod(ApiMethod method) {
    _method = method;
    notifyListeners();
  }

  //
  List<String> get parameterNames {
    final p = _parameterNames.map((param) => param).toList();
    p.sort();
    return p;
  }

  // void addParameterName(String param) {
  //   _parameterNames.add(param);
  //   notifyListeners();
  // }
  void addParameterName() {
    _parameterNames.add(_newApiParameter);
    _newApiParameter = '';
    notifyListeners();
  }

  void deleteParameterName(String param) {
    _parameterNames.remove(param);
    notifyListeners();
  }

  //
  // convenience getter for building the URL
  String get path => _ontapApiPath + _api;
  //
  // some ephemereal state
  String _newApiParameter = '';
  void setNewParameter(String param) {
    _newApiParameter = param;
  }
}
