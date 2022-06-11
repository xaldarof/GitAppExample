import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:git_app/data/model/remote/GitRepositoryResponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/remote/GitAccountResponse.dart';
import '../parsers.dart';

class RemoteDataSource {
  Future<List<GitAccountResponse>> getAccounts(String query, int page) async {
    var response =
    await http.get(Uri.parse("$BASE_URL/search/users?q=$query&page=$page"));

    return compute(parseAccountsJson, response.body);
  }

  Future<GitAccountResponse> getByLogin(String login) async {
    var response = await http.get(Uri.parse("$BASE_URL/users/$login"));

    return GitAccountResponse.fromJson(jsonDecode(response.body));
  }

  Future<List<GitAccountResponse>> getAccountFollowers(String login) async {
    var response = await http.get(Uri.parse("$BASE_URL/users/$login/followers"),
        headers: {"Authorization": "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"});

    print("Response = ${response.body}");

    return compute(parseAccountFollowersJson, response.body);
  }

  Future<List<GitRepositoryResponse>> getAccountRepos(String login) async {
    var response = await http.get(Uri.parse("$BASE_URL/users/$login/repos"),
        headers: {"Authorization": "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"});

    if (kDebugMode) {
      print("Response = ${response.body}");
    }

    return compute(parseAccountReposJson, response.body);
  }

  static const BASE_URL = "https://api.github.com";
}
