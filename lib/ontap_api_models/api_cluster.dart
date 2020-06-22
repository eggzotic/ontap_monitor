//
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiCluster {
  final String name;
  final String uuid;
  final String contact;
  final String location;
  final bool isAsa;

  // for storing these
  Map<String, dynamic> get toMap => {
        'name': name,
        'uuid': uuid,
        'contact': contact,
        'location': location,
        'san_optimized': isAsa,
      };
  String get asJson => json.encode(toMap);
  //
  // for re-inflating
  ApiCluster._private({
    @required this.uuid,
    String name = '',
    String contact = '',
    String location = '',
    bool isAsa = false,
  })  : this.name = name,
        this.contact = contact,
        this.location = location,
        this.isAsa = isAsa;

  factory ApiCluster.fromMap(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final uuid = json['uuid'] as String;
    final contact = json['contact'] as String;
    final location = json['location'] as String;
    final isAsa = json['san_optimized'] as bool;
    return ApiCluster._private(
      uuid: uuid,
      contact: contact,
      location: location,
      name: name,
      isAsa: isAsa,
    );
  }
  //
  factory ApiCluster.fromJson(String text) {
    return ApiCluster.fromMap(json.decode(text));
  }
}
