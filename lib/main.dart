import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_app/bloc/core/core_screen_bloc.dart';
import 'package:git_app/bloc/search_screen_bloc.dart';
import 'package:git_app/ui/CoreScreen.dart';
import 'package:git_app/ui/routes.dart';
import 'package:git_app/ui/screens/FavoritesScreen.dart';
import 'package:git_app/ui/screens/SearchScreen.dart';

import 'bloc/favorites_screen_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CoreScreenBloc>(create: (context) => CoreScreenBloc()),
    BlocProvider<SearchScreenBloc>(create: (context) => SearchScreenBloc()),
    BlocProvider<FavoritesScreenBloc>(
        create: (context) => FavoritesScreenBloc()),
  ], child: GitApp()));
}

class GitApp extends StatefulWidget {
  @override
  State<GitApp> createState() => _GitAppState();
}

class _GitAppState extends State<GitApp> {
  final screens = [SearchScreen(), FavoritesScreen()];

  var currentItem = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
        initialRoute: CORE_SCREEN,
        debugShowCheckedModeBanner: false,
        routes: {
          SEARCH_SCREEN: (context) => SearchScreen(),
          FAVORITE_ACCOUNTS_SCREEN: (context) => FavoritesScreen(),
          CORE_SCREEN: (context) => CoreScreen()
        });
  }
}
