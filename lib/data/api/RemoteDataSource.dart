
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/remote/GitAccountResponse.dart';
import '../parsers.dart';

class RemoteDataSource {

  Future<List<GitAccountResponse>> getAccounts(String query,int page) async {
    var response = await http
        .get(Uri.parse("$BASE_URL/search/users?q=$query&page=$page"));


    return compute(parseAccountsJson, response.body);
  }

  Future<GitAccountResponse> getByLogin(String login) async {
    var response = await http.get(Uri.parse("$BASE_URL/users/$login"));

    return GitAccountResponse.fromJson(jsonDecode(response.body));
  }

  static const BASE_URL = "https://api.github.com";
}
