import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:git_app/controllers/repositories_controller.dart';
import 'package:git_app/data/model/remote/GitRepositoryResponse.dart';

import '../../../controllers/user_info_controller.dart';
import '../../../data/model/ui/GitAccount.dart';

class RepositoriesScreen extends StatelessWidget {
  String login;

  RepositoriesScreen({required this.login});

  RepositoriesController controller = Get.put(RepositoriesController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.getAccountRepos(login);
    });

    return GetBuilder<FollowersScreenController>(builder: (tx) {
      if (controller.state == ReposState.SUCCESS) {
        return buildListView(context, controller.accounts ?? []);
      }
      if (controller.state == ReposState.LOADING) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.state == ReposState.ERROR) {
        return const Center(child: Text("Something went wrong"));
      }

      return const Center(child: Text("Nothing to show"));
    });
  }

  Widget buildListView(BuildContext context, List<GitRepositoryResponse> accounts) {
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
                    const Padding(padding: EdgeInsets.all(12)),
                    Text(accounts[index].fullName.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              onTap: () {},
            );
          });
    }
  }

