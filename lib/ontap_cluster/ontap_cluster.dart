//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:uuid/uuid.dart';

class OntapCluster extends StorableItem {
  final String _id;
  String _name;
  String _description;
  String _adminLifAddress;
  String _credentialsId;
  Set<String> _actionIds = {};
  Map<String, Set<String>> _cachedActionResultIds = {};
  //
  // to be used from outside - creating a new instance to be populated by the user
  factory OntapCluster() {
    return OntapCluster._private(id: Uuid().v4());
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
    Map<String, Set<String>> cachedActionResultId,
  })  : assert(id != null),
        _id = id,
        super(lastUpdated: lastUpdated) {
    _name = name;
    _adminLifAddress = adminLifAddress;
    _credentialsId = credentialsId;
    _description = description;
    _actionIds = actionIds ?? Set<String>();
    _cachedActionResultIds = cachedActionResultId ?? {};
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
    final Map<String, Set<String>> cachedActionResultId =
        Map.from(json['cachedActionResultId'])
            .map((key, value) => MapEntry(key, Set.from(value)));
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
  @override
  Map<String, dynamic> get toMap => {
        'id': _id,
        'name': _name,
        'adminLifAddress': _adminLifAddress,
        'credentialsId': _credentialsId,
        'description': _description,
        'actionIds': _actionIds.toList(),
        'lastUpdated': lastUpdated.toIso8601String(),
        'cachedActionResultId':
            _cachedActionResultIds.map((k, v) => MapEntry(k, v.toList())),
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
  // Cached Result ID handling
  Set<String> cachedResultIdsFor(String actionId) =>
      _cachedActionResultIds[actionId] ?? {};
  void setCachedResultId(String actionId, Set<String> resultIds) {
    _cachedActionResultIds[actionId] = resultIds;
    notifyListeners();
  }

  void clearCachedResultIds() {
    _cachedActionResultIds.clear();
    notifyListeners();
  }

  //
  // clear stale action IDs
  int clearStaleActionIds({
    @required ItemStore<OntapAction> usingStore,
  }) {
    final staleIds =
        _actionIds.where((id) => !usingStore.existsForId(id)).toList();
    final deletedStaleActionIdCount = staleIds.length;
    staleIds.forEach((id) => _actionIds.remove(id));
    // to commit to persistent storage via the listener in the upstream datastore
    notifyListeners();
    return deletedStaleActionIdCount;
  }

  //
  // ephemeral state
  bool _credentialsRequired = false;
  bool get credentialsRequired => _credentialsRequired;
  void setCredentialsRequired(bool value) => _credentialsRequired = value;
}
