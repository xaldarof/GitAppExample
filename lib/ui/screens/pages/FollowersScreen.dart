import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/user_info_controller.dart';
import '../../../data/model/ui/GitAccount.dart';

class FollowersScreen extends StatelessWidget {
  String login;

  FollowersScreen({required this.login});

  FollowersScreenController controller = Get.put(FollowersScreenController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAccountFollowers(login);
    });

    return Column(children: [
      Expanded(child: GetBuilder<FollowersScreenController>(builder: (tx) {
        if (controller.state == InfoState.LOADING) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.state == InfoState.ERROR) {
          return const Center(child: Text("Something went wrong"));
        }

        if (controller.state == InfoState.SUCCESS) {
          return buildListView(context, controller.accounts ?? []);
        }
        return const Center(child: Text("Nothing to show"));
      }))
    ]);
  }

  Widget buildListView(BuildContext context, List<GitAccount> accounts) {
    if (accounts.isNotEmpty) {
      return ListView.builder(
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
                  ],
                ),
              ),
              onTap: () {},
            );
          });
    } else {
      return const Center(child: Text("Nothing to show"));
    }
  }
}
