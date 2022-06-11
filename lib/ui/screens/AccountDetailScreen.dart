import 'package:flutter/material.dart';
import 'package:git_app/ui/screens/pages/FollowersScreen.dart';
import 'package:git_app/ui/screens/pages/RepositoriesScreen.dart';

import '../../data/model/ui/GitAccount.dart';

class AccountDetailScreen extends StatelessWidget {
  final GitAccount account;

  AccountDetailScreen({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                account.login,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                      child: Column(children: const [
                    Icon(
                      Icons.follow_the_signs,
                      color: Colors.black,
                    ),
                    Text(
                      "Followers",
                      style: TextStyle(color: Colors.black),
                    )
                  ])),

                  Tab(
                      child: Column(children: const [
                    Icon(
                      Icons.account_tree,
                      color: Colors.black,
                    ),
                    Text(
                      "Repositories",
                      style: TextStyle(color: Colors.black),
                    )
                  ])),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                FollowersScreen(login: account.login),
                RepositoriesScreen(login: account.login)
              ],
            )));
  }

  Widget buildListView(BuildContext context, List<GitAccount> accounts) {
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
                          Text(accounts[index].login,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const Spacer(),
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
