
import 'package:json_annotation/json_annotation.dart';
import 'package:build_runner/build_runner.dart';
import 'package:json_serializable/json_serializable.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name, lastName, add;
  bool subscription;

  User({required this.name,required this.lastName,required this.add,required this.subscription,});

  factory User.fromJson(Map<String,dynamic> data) => _$UserFromJson(data);

  Map<String,dynamic> toJson() => _$UserToJson(this);

}