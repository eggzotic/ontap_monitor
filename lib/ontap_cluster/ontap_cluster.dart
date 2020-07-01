//
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/data_item.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:uuid/uuid.dart';

class OntapCluster extends DataItem {
  static const idPrefix = 'ontap-cluster_';
  final String _id;
  String _name;
  String _description;
  String _adminLifAddress;
  String _credentialsId;
  Set<String> _actionIds;
  DateTime _lastUpdated;
  Map<String, String> _cachedActionResultId;
  // String _cachedApiOntapClusterId;
  //
  // to be used from outside,
  factory OntapCluster() {
    final uuid = Uuid();
    final v4 = idPrefix + uuid.v4();
    return OntapCluster._private(id: v4, lastUpdated: DateTime.now());
  }
  //
  // all instances should ultimately be created by this, suitably wrapped in a
  //  factory constructor
  OntapCluster._private({
    @required String id,
    String name = '',
    String adminLifAddress = '',
    String credentialsId = '',
    String description = '',
    Set<String> actionIds,
    DateTime lastUpdated,
    Map<String, String> cachedActionResultId,
  })  : assert(id != null),
        _id = id {
    _name = name;
    _adminLifAddress = adminLifAddress;
    _credentialsId = credentialsId;
    _description = description;
    _actionIds = actionIds ?? Set<String>();
    _lastUpdated = lastUpdated;
    _cachedActionResultId = cachedActionResultId ?? {};
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
    final DateTime lastUpdated = DateTime.parse(json['lastUpdated']);
    final Map<String, String> cachedActionResultId =
        Map<String, String>.from(json['cachedActionResultId']);
    //
    return OntapCluster._private(
      id: id,
      name: name,
      adminLifAddress: adminLifAddress,
      credentialsId: credentialsId,
      description: description,
      actionIds: actionIds,
      lastUpdated: lastUpdated,
      cachedActionResultId: cachedActionResultId,
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
        'lastUpdated': _lastUpdated.toString(),
        'cachedActionResultId': _cachedActionResultId,
      };
  //
  static String _tidyText(String text) {
    String cleanText = text.trim();
    // insert more tidying steps here, as they become necessary
    return cleanText;
  }

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
  DateTime get lastUpdated => _lastUpdated;

  void setLastUpdated(DateTime date) {
    _lastUpdated = date;
    notifyListeners();
  }

  //
  // Cached Result ID handling
  String cachedResultIdFor(String actionId) => _cachedActionResultId[actionId];
  void setCachedResultId(String actionId, String resultId) {
    _cachedActionResultId[actionId] = resultId;
    notifyListeners();
  }

  void clearCachedResultIds() {
    _cachedActionResultId.clear();
    notifyListeners();
  }

  //
  // clear stale action IDs
  int clearStaleActionIds({
    @required DataStore<OntapAction> usingActionStore,
  }) {
    final staleIds =
        _actionIds.where((id) => !usingActionStore.existsForId(id)).toList();
    final deletedStaleActionIdCount = staleIds.length;
    staleIds.forEach((id) => _actionIds.remove(id));
    notifyListeners(); // to commit to persistent storage via the listener in the upstream datastore
    return deletedStaleActionIdCount;
  }

  //
  // ephemeral state
  bool _credentialsRequired = false;
  bool get credentialsRequired => _credentialsRequired;
  void setCredentialsRequired(bool value) => _credentialsRequired = value;
}
