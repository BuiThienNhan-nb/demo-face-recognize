// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:face_recognize_demo/utils/extensions/float32list_extensions.dart';
import 'package:flutter/foundation.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final Float32List faceInfo;
  const UserModel({
    required this.id,
    required this.name,
    required this.faceInfo,
  });

  UserModel copyWith({
    String? id,
    String? name,
    Float32List? faceInfo,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      faceInfo: faceInfo ?? this.faceInfo,
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'name': name,
      'faceInfo': List<double>.from(faceInfo),
    };
  }

  factory UserModel.fromMap(Map<String, Object?> map) {
    return UserModel(
      id: (map['id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      faceInfo:
          ((map['faceInfo'] ?? <Object?>[]) as List<Object?>).toFloat32List(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, faceInfo];
}
