import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

//
class ClusterCredentials with ChangeNotifier {
  //
  final String _id;
  String _name;
  String _userName;
  String _password;
  String _description;
  //
  // create a new credentials from scratch
  factory ClusterCredentials() {
    final uuid = Uuid();
    final v4 = uuid.v4();
    return ClusterCredentials._private(id: v4);
  }
  //
  ClusterCredentials._private({
    @required String id,
    String name = '',
    String userName = '',
    String password = '',
    String description = '',
  })  : assert(id != null),
        _id = id {
    _name = name;
    _userName = userName;
    _password = password;
    _description = description;
  }
  //
  factory ClusterCredentials.fromJson(String encoded) {
    return ClusterCredentials.fromMap(json.decode(encoded));
  }
  factory ClusterCredentials.fromMap(Map<String, dynamic> json) {
    final String id = json['id'];
    final String name = json['name'];
    final String userName = utf8.decode(base64.decode(json['userName']));
    final String password = utf8.decode(base64.decode(json['password']));
    final String description = json['description'];
    //
    return ClusterCredentials._private(
        id: id,
        name: name,
        userName: userName,
        password: password,
        description: description);
  }
  //
  Map<String, String> get toMap => {
        'id': _id,
        'name': _name,
        'userName': base64.encode(utf8.encode(_userName)),
        'password': base64.encode(utf8.encode(_password)),
        'description': _description,
      };
  //
  String get asJson => json.encode(toMap);
  //
  bool get isValid =>
      _userName.isNotEmpty && _name.isNotEmpty && _id.isNotEmpty;
  //
  String get id => _id;
  //
  // Setting & getting the name
  void setName(String newName) {
    _name = _tidyText(newName);
    notifyListeners();
  }

  String get name => _name;
  //
  // Getting & setting the username
  void setUserName(String newUser) {
    _userName = _tidyText(newUser);
    notifyListeners();
  }

  String get userName => _userName;
  //
  // Getting & setting the password
  void setPassword(String newPass) {
    final realPassword = newPass.trim();
    _password = realPassword;
    notifyListeners();
  }

  String get password => _password;
  String get passwordMasked => ''.padRight(_password.length, '*');

  //
  // Description get & set
  void setDescription(String newDescription) {
    final realDescription = _tidyText(newDescription);
    _description = realDescription;
    notifyListeners();
  }

  String get description => _description;

  //
  // helper function to perform common tidying tasks on text
  static String _tidyText(String text) {
    String newText = text.trim();
    // other tidying tasks here?
    return newText;
  }
}
