import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthenticationResponse extends Equatable {
  final String token;

  const AuthenticationResponse({
    required this.token,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'token': token});

    return result;
  }

  factory AuthenticationResponse.fromMap(Map<String, dynamic> map) {
    return AuthenticationResponse(
      token: map['token'] ?? '',
    );
  }

  @override
  List<Object> get props => [token];

  String toJson() => json.encode(toMap());

  factory AuthenticationResponse.fromJson(String source) => AuthenticationResponse.fromMap(json.decode(source));
}