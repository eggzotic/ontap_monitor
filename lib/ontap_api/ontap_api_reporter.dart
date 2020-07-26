//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:ontap_monitor/ontap_api_models/api_request_state.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:rest_client/rest_client.dart';

class OntapApiReporter<T extends StorableItem>
    with ChangeNotifier
    implements Reporter {
  OntapApiReporter({
    @required this.owner,
    @required this.dataStore,
    @required this.actionId,
  });
  // The status of the associated request
  ApiRequestState _statusValue = ApiRequestState.notStarted;
  ApiRequestState get _status => _statusValue;
  ApiRequestState get status => _status;
  set _status(ApiRequestState value) {
    _statusValue = value;
    notifyListeners();
  }

  /// the response data will be inserted into this property
  List<T> _responseObjects;
  // and can be fetched from here
  List<T> get responseObject => _responseObjects;

  /// the "owner" of this response
  final OntapCluster owner;

  /// where to store the object
  final ItemStore<T> dataStore;

  /// the action ID this reporter is working for
  final String actionId;

  void reset() {
    _status = ApiRequestState.notStarted;
  }

  /// Called when the [RestClient] encounters an failed response or exception.
  /// All times are UTC Millis.
  Future<void> failure({
    @required int endTime,
    @required String exception,
    @required String method,
    @required String requestId,
    @required StackTrace stack,
    @required int startTime,
    @required String url,
  }) {
    print('Failure exception: $exception');
    print('Failure url: $url');
    print('Failure Request ID: $requestId');
    _status = ApiRequestState.completeFail;
    return null;
  }

  /// Called by the [RestClient] just before making the network call.  The given
  /// [requestId] will be consistent for subsequent calls and can be used to
  /// tie updated statuses to this request.
  Future<void> request({
    @required dynamic body,
    @required Map<String, String> headers,
    @required String method,
    @required String requestId,
    @required String url,
  }) {
    print('Request headers: $headers');
    // print('Request body: $body');
    print('Request url:  $url');
    _status = ApiRequestState.started;
    return null;
  }

  /// Called by the [RestClient] just after receiving the response from the
  /// remote server.
  Future<void> response({
    @required dynamic body,
    @required Map<String, String> headers,
    @required String requestId,
    @required int statusCode,
  }) {
    print('Response status: $statusCode');
    print('Response headers: $headers');
    print('Response body: $body');
    print('Request ID: $requestId');
    //
    if (statusCode < 200 || statusCode > 299) {
      _status = ApiRequestState.completeFail;
      return null;
    }

    final Map<String, dynamic> bodyAsMap = Map.from(json.decode(body));
    if (bodyAsMap.containsKey('records')) {
      print('Begin create List<$T> fromMap');
      final List<Map<String, dynamic>> listOfRecords =
          List.from(bodyAsMap['records']);
      _responseObjects = listOfRecords
          .map((e) => dataStore.itemFromMap(e, ownerId: owner.id))
          .toList();
      print('End create List<$T> fromMap');
    } else {
      // otherwise we have a single-record response
      print('Begin create $T fromMap');
      // create a 1-element list
      _responseObjects = [dataStore.itemFromMap(bodyAsMap, ownerId: owner.id)];
      print('End create $T fromMap');
    }
    _responseObjects.forEach((obj) {
      dataStore.add(obj);
    });
    owner.setCachedResultId(
        actionId, _responseObjects.map((e) => e.id).toSet());
    _status = ApiRequestState.completeSuccess;
    return null;
  }

  /// Called by the [RestClient] when a successful response has been processed.
  /// All times are UTC Millis.
  Future<void> success({
    @required int bytesReceived,
    @required int bytesSent,
    @required int endTime,
    @required String method,
    @required String requestId,
    @required int startTime,
    @required int statusCode,
    @required String url,
  }) {
    return null;
  }
}
