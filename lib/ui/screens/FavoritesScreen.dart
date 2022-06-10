import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_app/controllers/favorites_controller.dart';

import '../../data/cache/AccountCacheModel.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesController controller = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24))),
          title: const Text(
            "Github",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: GetBuilder<FavoritesController>(
            builder: (tx) =>
                buildListView(context, controller.accounts ?? [])));
  }

  Widget buildListView(BuildContext context, List<AccountCacheModel> accounts) {
    if (accounts.isNotEmpty) {
      return Column(children: [
        Expanded(
            child: ListView.builder(
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
                          Text(accounts[index].login),
                          const Spacer(),
                          Text(accounts[index].id.toString()),
                          const Padding(padding: EdgeInsets.all(12)),
                        ],
                      ),
                    ),
                    onTap: () {},
                  );
                }))
      ]);
    } else {
      return const Center(child: Text("Nothing to show"));
    }
  }
}
