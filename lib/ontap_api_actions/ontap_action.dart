import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/data_item.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_api/ontap_api.dart';
import 'package:ontap_monitor/ontap_api_reporter.dart';
import 'package:uuid/uuid.dart';
import 'package:rest_client/rest_client.dart' as rc;

//
class OntapAction extends DataItem {
  static const idPrefix = 'ontap-action_';
  // static const _ontapApiPath = '/api/';
  static int _builtinActionId = 0;
  //
  final String _id;
  String _name;
  String _description;
  OntapApi _api;
  // ApiMethod _method;
  // Set<String> _parameterNames;
  final bool _builtin;
  //
  factory OntapAction({bool builtin = false}) {
    final uuid = Uuid();
    final v4 = idPrefix +
        (builtin ? ('builtin_' + _builtinActionId.toString()) : uuid.v4());
    if (builtin) {
      _builtinActionId += 1;
    }
    return OntapAction._private(id: v4, builtin: builtin);
  }
  OntapAction._private({
    @required String id,
    String name = '',
    String description = '',
    OntapApi api,
    // ApiMethod method = ApiMethod.get,
    // Set<String> parameterNames,
    bool builtin = false,
  })  : _id = id,
        _builtin = builtin {
    _name = name;
    _description = description;
    _api = api;
    // _method = method;
    // _parameterNames = parameterNames ?? Set<String>();
  }
  //
  Map<String, dynamic> get toMap => {
        'id': _id,
        'name': _name,
        'description': _description,
        'api': _api.id,
      };
  //
  factory OntapAction.fromMap(Map<String, dynamic> json) {
    print('OntapAction.fromMap: json = $json');
    final String id = json['id'];
    final String name = json['name'];
    final String description = json['description'];
    final OntapApi api = OntapApi.forId(json['api']);
    // final int methodIndex = json['methodIndex'];
    // final method = ApiMethod.fromIndex(methodIndex);
    // final Set<String> parameterNames = Set.from(json['parameterNames']);
    return OntapAction._private(
      id: id,
      name: name,
      description: description,
      api: api,
      // method: method,
      // parameterNames: parameterNames,
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
  // ApiMethod get method => _method;
  // void setMethod(ApiMethod method) {
  //   _method = method;
  //   notifyListeners();
  // }

  //
  // List<String> get parameterNames {
  //   final p = _parameterNames.map((param) => param).toList();
  //   p.sort();
  //   return p;
  // }

  // void addParameterName() {
  //   _parameterNames.add(_newApiParameter);
  //   _newApiParameter = '';
  //   notifyListeners();
  // }

  // void deleteParameterName(String param) {
  //   _parameterNames.remove(param);
  //   notifyListeners();
  // }

  //

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
  static final List<OntapAction> _builinActions = [
    OntapAction(builtin: true)
      ..setName('Cluster Info')
      ..setDescription('Builtin Action')
      ..setApi(OntapApi.forId('cluster+GET')),
    // ..setMethod(ApiMethod.get),
    // OntapAction(builtin: true)
    //   ..setName('Cluster Nodes')
    //   ..setDescription('Builtin Action')
    //   ..setApi('cluster/nodes')
    //   ..setMethod(ApiMethod.get),
    // OntapAction(builtin: true)
    //   ..setName('Cluster Peers')
    //   ..setDescription('Builtin Action')
    //   ..setApi('cluster/peers')
    //   ..setMethod(ApiMethod.get),
    OntapAction(builtin: true)
      ..setName('Cluster Licenses')
      ..setDescription('Builtin Action')
      ..setApi(OntapApi.forId('cluster/licensing/licenses+GET')),
    // ..setMethod(ApiMethod.get)
    // ..setNewParameter('fields=*'),
  ];
  static bool _builtinsAdded = false;
  static void addBuiltins(DataStore<OntapAction> dataStore) {
    if (_builtinsAdded) return;
    // print('Begin add builtins');
    _builinActions.forEach((action) {
      // print('Begin add builtin ${action.name}, ${action.id}');
      // print('API ${action.api.name}, ${action.api.id}');
      dataStore.add(
        action,
        storeNow: false,
        neverStore: true,
      );
    });
    print('Completed add builtins');
    // ensure this only runs once!
    _builtinsAdded = true;
  }

  //
  // some ephemereal state
  String _newApiParameter = '';
  // set only - no get!
  void setNewParameter(String param) {
    _newApiParameter = param;
  }

  bool get newApiParamValid => _newApiParameter.isNotEmpty;
}
