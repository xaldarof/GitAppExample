import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_app/bloc/favorites_screen_bloc.dart';

import '../../data/cache/AccountCacheModel.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavoritesScreenBloc>(context)
        .add(OnEnterScreen());

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            BlocProvider.of<FavoritesScreenBloc>(context).add(OnEnterScreen());
          },
        ),
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
        body: Column(children: [
          Expanded(child:
              BlocBuilder<FavoritesScreenBloc, FavoritesScreenState>(
                  builder: (context, state) {

            if (state is OnEnterScreenState) {
              return buildListView(context, state.accounts);
            }
            return Container();
          }))
        ]));
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
                              accounts[index].avatarUrl??"",
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
