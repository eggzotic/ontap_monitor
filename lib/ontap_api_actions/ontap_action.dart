import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/ontap_api/ontap_api.dart';
import 'package:ontap_monitor/ontap_api_reporter.dart';
import 'package:uuid/uuid.dart';
import 'package:rest_client/rest_client.dart' as rc;
import 'package:ontap_monitor/ontap_api_models/api_method.dart';

//
class OntapAction extends StorableItem {
  /// used to help generate unique IDs for the builtin Actions, so that their
  /// IDs will be constant across invocations. Since builtins are not stored
  /// persistently, they might otherwise get a random ID each time the app starts
  static int _builtinActionId = 0;
  //
  final String _id;
  String _name;
  String _description;
  OntapApi _api;
  final bool _builtin;
  //
  factory OntapAction({bool builtin = false}) {
    final uuid = Uuid();
    final v4 = builtin ? ('builtin_' + _builtinActionId.toString()) : uuid.v4();
    if (builtin) _builtinActionId += 1;
    //
    return OntapAction._private(id: v4, builtin: builtin);
  }
  OntapAction._private({
    @required String id,
    String name = '',
    String description = '',
    OntapApi api,
    DateTime lastUpdated,
    bool builtin = false,
  })  : _id = id,
        _builtin = builtin,
        super(lastUpdated: lastUpdated) {
    _name = name;
    _description = description;
    _api = api;
  }
  //
  Map<String, dynamic> get toMap => {
        'id': _id,
        'name': _name,
        'description': _description,
        'api': _api.id,
        'lastUpdated': lastUpdated.toIso8601String(),
      };
  //
  factory OntapAction.fromMap(Map<String, dynamic> json) {
    final String id = json['id'];
    final String name = json['name'];
    final String description = json['description'];
    final OntapApi api = OntapApi.forId(json['api']);
    final DateTime lastUpdated = DateTime.parse(json['lastUpdated']);
    return OntapAction._private(
      id: id,
      name: name,
      description: description,
      api: api,
      lastUpdated: lastUpdated,
    );
  }
  //
  bool get isBuiltin => _builtin;
  bool get isEditable => !_builtin;
  //
  bool get isValid => _name.isNotEmpty && _api != null;
  //
  String get id => _id;
  //
  String get name => _name;
  void setName(String newName) {
    final cName = newName.trim();
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
  OntapApi get api => _api;
  void setApi(OntapApi newApi) {
    _api = newApi;
    notifyListeners();
  }

  //
  Future<void> execute({
    @required String host,
    @required ClusterCredentials credentials,
    @required OntapApiReporter reporter,
  }) async {
    final client = rc.Client(reporter: reporter);
    final url = Uri(
      scheme: 'https',
      host: host,
      path: _api.path,
      queryParameters: _api.parameterMap,
    );
    final request = rc.Request(
      url: url.toString(),
      method: _api.method.requestMethod,
    );
    await client.execute(
      request: request,
      authorizer: rc.BasicAuthorizer(
        username: credentials.userName,
        password: credentials.password,
      ),
    );
  }

  //
  // some builtin Actions
  // never delete/insert - append-only here - so that the builtin IDs will
  //  remain consistent
  static final List<OntapAction> _builinActions = [
    OntapAction(builtin: true)
      ..setName('Cluster Info')
      ..setDescription('Builtin Action')
      ..setApi(OntapApi.forId('GET cluster')),
    OntapAction(builtin: true)
      ..setName('Cluster Licenses')
      ..setDescription('Builtin Action')
      ..setApi(OntapApi.forId('GET cluster/licensing/licenses')),
    OntapAction(builtin: true)
      ..setName('Cluster Nodes')
      ..setDescription('Builtin Action')
      ..setApi(OntapApi.forId('GET cluster/nodes')),
    OntapAction(builtin: true)
      ..setName('Ethernet Ports')
      ..setDescription('Builtin Action')
      ..setApi(OntapApi.forId('GET network/ethernet/ports')),
    OntapAction(builtin: true)
      ..setName('Disks')
      ..setDescription('Builtin Action')
      ..setApi(OntapApi.forId('GET storage/disks')),
    OntapAction(builtin: true)
      ..setName('Aggregates')
      ..setDescription('Builtin Action')
      ..setApi(OntapApi.forId('GET storage/aggregates')),
    OntapAction(builtin: true)
      ..setName('Cluster Storage Summary')
      ..setDescription('Builtin Action')
      ..setApi(OntapApi.forId('GET storage/cluster')),
  ];
  static bool _builtinsAdded = false;
  static void addBuiltins(ItemStore<OntapAction> dataStore) {
    if (_builtinsAdded) return;
    _builinActions.forEach((action) {
      dataStore.add(
        action,
        storeNow: false,
        neverStore: true,
      );
    });
    // ensure this only runs once!
    _builtinsAdded = true;
  }

  // disabled due to Actions currently being builtin-only
  //
  // // some ephemereal state
  // String _newApiParameter = '';
  // // set only - no get!
  // void setNewParameter(String param) {
  //   _newApiParameter = param;
  // }

  // bool get newApiParamValid => _newApiParameter.isNotEmpty;
}
