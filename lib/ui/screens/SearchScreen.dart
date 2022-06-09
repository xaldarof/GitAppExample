import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_app/data/cache/core_database.dart';
import 'package:git_app/data/model/ui/GitAccount.dart';

import '../../bloc/search_screen_bloc.dart';
import '../../data/model/remote/GitAccountResponse.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(
                    left: 12, right: 12, top: 12, bottom: 0),
                child: SafeArea(
                    child: TextField(
                  onChanged: (str) {
                    if (str.isNotEmpty) {
                      BlocProvider.of<SearchScreenBloc>(context)
                          .add(OnQueryTextChangeEvent(query: str));
                    }
                  },
                  controller: textEditingController,
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
                  var color = Colors.black;
                  if (accounts[index].isFavorite) {
                    color = Colors.red;
                  } else {
                    color = Colors.black;
                  }

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
                      margin: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Padding(padding: const EdgeInsets.all(12)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              accounts[index].avatarUrl??"",
                              height: 62.0,
                              width: 62.0,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(12)),
                          Text(accounts[index].login??""),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(4),
                                  child: Icon(color: color, Icons.favorite)),
                            ],
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      showBottomSheetMine(context, accounts[index]);
                    },
                  );
                }))
      ]);
    } else {
      return const Center(child: Text("Nothing to show"));
    }
  }

  TextEditingController nameController = TextEditingController();

  void showBottomSheetMine(BuildContext context, GitAccount gitAccount) {
    nameController.text = gitAccount.login??"";
    BlocProvider.of<SearchScreenBloc>(context).add(OnSelectSingleInformation(gitAccount.realLogin??""));

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.white,
              margin: const EdgeInsets.only(
                  left: 12, right: 12, top: 0, bottom: 12),
              child: BlocBuilder<SearchScreenBloc, SearchScreenState>(
                  builder: (context, state) {
                if (state is LoadingSingleAccountInformationState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is LoadedSingleAccountInformationState) {
                  return buildAccountInfoWidget(context, state.account);
                }
                if(state is AddedToFavoritesState) {
                  Navigator.pop(context);
                }
                return Container();
              }));
        });
  }

  Widget buildAccountInfoWidget(BuildContext context, GitAccount account) {
    var color = Colors.black;
    if (account.isFavorite) {
      color = Colors.red;
    } else {
      color = Colors.black;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
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
          margin: EdgeInsets.all(12),
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.all(12)),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  account.avatarUrl??"",
                  height: 62.0,
                  width: 62.0,
                ),
              ),
              const Padding(padding: EdgeInsets.all(12)),
              Text(nameController.text),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: const EdgeInsets.all(4),
                      child: Icon(color: color, Icons.favorite)),
                ],
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.all(12),
            child: TextField(
              onChanged: (str) {
                nameController.text = str;
                nameController.selection = TextSelection.fromPosition(
                    TextPosition(offset: nameController.text.length));
              },
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: account.login,
                  fillColor: Colors.white70),
            )),
        const Padding(padding: EdgeInsets.all(12)),
        Row(
          children: [
            const Spacer(),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 52,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueAccent, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(14))),
                child: const Text("ADD"),
              ),
              onTap: () {
                BlocProvider.of<SearchScreenBloc>(context).add(
                    AddToFavoritesEvent(GitAccount(
                        id: account.id,
                        login: nameController.text,
                        avatarUrl: account.avatarUrl,
                        isFavorite: account.isFavorite)));
              },
            ),
            const Padding(padding: EdgeInsets.all(8))
          ],
        )
      ],
    );
  }
}
