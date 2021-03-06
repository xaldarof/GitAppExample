import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:git_app/controllers/search_controller.dart';
import 'package:git_app/controllers/user_info_controller.dart';
import 'package:git_app/data/model/ui/GitAccount.dart';
import 'package:git_app/ui/screens/AccountDetailScreen.dart';

import '../../controllers/repositories_controller.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController queryController = TextEditingController();
  SearchController controller = Get.put(SearchController());

  ScrollController scrollController = ScrollController();

  void initListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.updateCurrentPage();
        controller.searchAccount(queryController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initListener();

    var map = <String, dynamic>{
      "username": "Temur",
      "password": "12345",
      "user": GitAccount(id: 1, login: "", avatarUrl: "", isFavorite: true)
    };

    print("Converted = ${jsonEncode(map)}");

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () {
            if (queryController.text.isNotEmpty) {
              controller.refreshPaging();
              controller.searchAccount(queryController.text);
            }
          },
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(
                    left: 12, right: 12, top: 12, bottom: 0),
                child: SafeArea(
                    child: TextField(
                  controller: queryController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Title...",
                      fillColor: Colors.white70),
                ))),
            Expanded(child: GetBuilder<SearchController>(builder: (controller) {
              if (controller.state == SearchState.LOADING) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.state == SearchState.LOADING_MORE_PAGE) {
                return buildListView(context, controller.accounts);
              }

              if (controller.state == SearchState.SUCCESS) {
                return buildListView(context, controller.accounts);
              }
              if (controller.state == SearchState.ERROR) {
                return const Center(child: Text("Something went wrong"));
              }

              return const Center(child: Text("Search something..."));
            }))
          ],
        ));
  }

  Widget buildListView(BuildContext context, List<GitAccount> accounts) {
    if (accounts.isNotEmpty) {
      return Column(children: [
        Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: accounts.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                offset: Offset(2, 2),
                                blurRadius: 2,
                                color: Colors.black12)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      margin: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Padding(padding: EdgeInsets.all(12)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              accounts[index].avatarUrl ?? "",
                              height: 62.0,
                              width: 62.0,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(12)),
                          Text(accounts[index].login,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const Spacer(),
                          GetBuilder<SearchController>(builder: (t) {
                            if (accounts[index].isFavorite) {
                              return GestureDetector(
                                  child: const Icon(Icons.favorite,
                                      color: Colors.red),
                                  onTap: () {
                                    controller.dispatchAccountState(index);
                                  });
                            } else {
                              return GestureDetector(
                                  child: const Icon(Icons.favorite,
                                      color: Colors.black),
                                  onTap: () {
                                    controller.dispatchAccountState(index);
                                  });
                            }
                          }),
                          const Padding(padding: EdgeInsets.all(12))
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.delete<FollowersScreenController>();
                      Get.delete<RepositoriesController>();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AccountDetailScreen(account: accounts[index]),
                        ),
                      );
                    },
                  );
                }))
      ]);
    } else {
      return const Center(child: Text("Nothing to show"));
    }
  }
}
