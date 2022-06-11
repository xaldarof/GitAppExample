// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GitRepositoryResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitRepositoryResponse _$GitRepositoryResponseFromJson(
        Map<String, dynamic> json) =>
    GitRepositoryResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      fullName: json['full_name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$GitRepositoryResponseToJson(
        GitRepositoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'description': instance.description,
    };
