import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:ontap_monitor/api_request_state.dart';
import 'package:ontap_monitor/data_storage/data_item.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:rest_client/rest_client.dart';

// class OntapApiReporter<T extends ApiResponseData>
class OntapApiReporter<T extends DataItem>
    with ChangeNotifier
    implements Reporter {
  OntapApiReporter({
    @required this.fromMap,
    @required this.owner,
    @required this.dataStore,
    @required this.actionId,
  });
  // a property to indicate the completion (non-null), success (true), failure
  //  (false) of the associated request
  ApiRequestState _statusValue = ApiRequestState.notStarted;
  ApiRequestState get _status => _statusValue;
  ApiRequestState get status => _status;
  set _status(ApiRequestState value) {
    _statusValue = value;
    notifyListeners();
  }

  /// the response data will be inserted into this property
  T _responseObject;
  // and can be fetched from here
  T get responseObject => _responseObject;
  // the constructor-from-map for our data-model, expressed a function (i.e.
  //  cannot simply pass the name of a constructor) "(map) => T.fromMap(map)",
  //  except generics do not support "T.fromMap" style names...
  final T Function(Map<String, dynamic>) fromMap;

  /// the "owner" of this response
  final OntapCluster owner;

  /// where to store the object
  final DataStore<T> dataStore;

  /// the action ID this reporter is working for
  final String actionId;

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
    print('Failure url:  $url');
    print('Request ID: $requestId');
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
    print('Request body: $body');
    print('Request url:  $url');
    print('Request ID: $requestId');
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
    if (statusCode >= 200 && statusCode <= 299) {
      print('Begin create $T fromMap');
      _responseObject = fromMap(json.decode(body));
      print('End create $T fromMap');
      dataStore.add(_responseObject);
      owner.setCachedResultId(actionId, _responseObject.id);
      // owner.setCachedApiOntapClusterId(_responseObject.id);
      _status = ApiRequestState.completeSuccess;
      return null;
    }
// ***RLS*** throw or otherwise indicate & notify of an error?
    _status = ApiRequestState.completeFail;
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
    print('Success status: $statusCode');
    print('Success url: $url');
    print('Request ID: $requestId');
    return null;
  }
}
