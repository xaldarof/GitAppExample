// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GitAccountResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitAccountResponse _$GitAccountResponseFromJson(Map<String, dynamic> json) =>
    GitAccountResponse(
      id: json['id'] as int?,
      login: json['login'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$GitAccountResponseToJson(GitAccountResponse instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
    };
