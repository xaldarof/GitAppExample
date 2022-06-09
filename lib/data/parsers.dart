import 'dart:convert';

import 'model/remote/GitAccountResponse.dart';

List<GitAccountResponse> parseAccountsJson(String responseBody) {
  final parsed = jsonDecode(responseBody)['items'].cast<Map<String, dynamic>>();

  return parsed
      .map<GitAccountResponse>((json) => GitAccountResponse.fromJson(json))
      .toList();
}