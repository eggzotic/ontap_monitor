import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rest_client/rest_client.dart';

/// Interface for receiving status updates and information from the
/// [RestClient].
class OntapApiReporter extends Reporter {
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
    // return Future(null);
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
    // return Future(null);
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
    // return Future(null);
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
    // return Future(null);
    return null;
  }
}
