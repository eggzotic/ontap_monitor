//
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class OntapCluster with ChangeNotifier {
  final String _id;
  String _name;
  String _description;
  String _adminLifAddress;
  String _credentialsId;
  Set<String> _actionIds;
  //
  // to be used from outside,
  factory OntapCluster() {
    final uuid = Uuid();
    final v4 = uuid.v4();
    return OntapCluster._private(id: v4);
  }
  //
  // all instances should ultimately be created by this, suitably wrapped in a factory constructor
  OntapCluster._private({
    @required String id,
    String name = '',
    String adminLifAddress = '',
    String credentialsId = '',
    String description = '',
    Set<String> actionIds,
  })  : assert(id != null),
        _id = id {
    _name = name;
    _adminLifAddress = adminLifAddress;
    _credentialsId = credentialsId;
    _description = description;
    _actionIds = actionIds ?? Set<String>();
  }
  factory OntapCluster.fromJson(String encoded) {
    return OntapCluster.fromMap(json.decode(encoded));
  }
  //
  // to be used to re-inflate a newly read DB record
  factory OntapCluster.fromMap(Map<String, dynamic> json) {
    final String id = json['id'];
    final String name = json['name'];
    final String adminLifAddress = json['adminLifAddress'];
    final String credentialsId = json['credentialsId'];
    final String description = json['description'];
    final Set<String> actionIds = Set.from(json['actionIds']);
    //
    return OntapCluster._private(
      id: id,
      name: name,
      adminLifAddress: adminLifAddress,
      credentialsId: credentialsId,
      description: description,
      actionIds: actionIds,
    );
  }
  //
  Map<String, dynamic> get toMap => {
        'id': _id,
        'name': _name,
        'adminLifAddress': _adminLifAddress,
        'credentialsId': _credentialsId,
        'description': _description,
        'actionIds': _actionIds.toList(),
      };
  //
  static String _tidyText(String text) {
    String cleanText = text.trim();
    // insert more tidying steps here, as they become necessary
    return cleanText;
  }

  //
  String get asJson => json.encode(toMap);
  //
  bool get isValid =>
      _name.isNotEmpty && _adminLifAddress.isNotEmpty && _id.isNotEmpty;
  //
  String get id => _id;
  //
  void setName(String newName) {
    _name = _tidyText(newName).toLowerCase();
    notifyListeners();
  }

  String get name => _name;
  //
  void setAdminLifAddress(String newAddress) {
    _adminLifAddress = _tidyText(newAddress).toLowerCase();
    notifyListeners();
  }

  String get adminLifAddress => _adminLifAddress;
  //
  void setCredentialsId(String id) {
    _credentialsId = id;
    notifyListeners();
  }

  String get credentialsId => _credentialsId;
  //
  void setDescription(String text) {
    _description = _tidyText(text);
    notifyListeners();
  }

  String get description => _description;
  //
  List<String> get actionIds => _actionIds.toList();
  int get actionCount => _actionIds.length;
  //
  void toggleActionId(String actionId) {
    _actionIds.contains(actionId)
        ? _actionIds.remove(actionId)
        : _actionIds.add(actionId);
    notifyListeners();
  }

  bool hasActionId(String actionId) => _actionIds.contains(actionId);
  //
  // ephemeral state
  bool _credentialsRequired = false;
  bool get credentialsRequired => _credentialsRequired;
  void setCredentialsRequired(bool value) => _credentialsRequired = value;
}
