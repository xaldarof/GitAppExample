import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_app/data/model/ui/GitAccount.dart';
import 'package:git_app/ui/screens/AccountDetailScreen.dart';

import '../../bloc/search_screen_bloc.dart';

class SearchScreen extends StatelessWidget {

  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () {
            if (queryController.text.isNotEmpty) {
              BlocProvider.of<SearchScreenBloc>(context)
                  .add(OnQueryTextChangeEvent(query: queryController.text));
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
            Expanded(child: BlocBuilder<SearchScreenBloc, SearchScreenState>(
              builder: (context, state) {
                if (state is SuccessSearchResultState) {
                  return buildListView(context, state.accounts);
                }
                if (state is SearchingAccountState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return buildListView(context, []);
              },
            ))
          ],
        ));
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
                          Text(accounts[index].login,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                          const Spacer(),

                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountDetailScreen(account: accounts[index]),
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
