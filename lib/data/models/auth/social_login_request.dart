import 'dart:convert';

import 'package:equatable/equatable.dart';

class SocialLoginRequest extends Equatable {
  final String name;
  final String email;
  const SocialLoginRequest({
    required this.name,
    required this.email,
  });

  SocialLoginRequest copyWith({
    String? name,
    String? email,
  }) {
    return SocialLoginRequest(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});

    return result;
  }

  factory SocialLoginRequest.fromMap(Map<String, dynamic> map) {
    return SocialLoginRequest(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialLoginRequest.fromJson(String source) =>
      SocialLoginRequest.fromMap(json.decode(source));

  @override
  String toString() => 'SocialLoginRequest(name: $name, email: $email)';

  @override
  List<Object> get props => [name, email];
}