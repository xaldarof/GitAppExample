import 'dart:convert';

import 'package:git_app/data/model/remote/GitRepositoryResponse.dart';

import 'model/remote/GitAccountResponse.dart';

List<GitAccountResponse> parseAccountsJson(String responseBody) {
  final parsed = jsonDecode(responseBody)['items'].cast<Map<String, dynamic>>();

  return parsed
      .map<GitAccountResponse>((json) => GitAccountResponse.fromJson(json))
      .toList();
}

List<GitAccountResponse> parseAccountFollowersJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<GitAccountResponse>((json) => GitAccountResponse.fromJson(json))
      .toList();
}

List<GitRepositoryResponse> parseAccountReposJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<GitRepositoryResponse>((json) => GitRepositoryResponse.fromJson(json))
      .toList();
}
