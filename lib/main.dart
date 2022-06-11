import 'package:flutter/material.dart';
import 'package:git_app/ui/CoreScreen.dart';
import 'package:git_app/ui/routes.dart';
import 'package:git_app/ui/screens/FavoritesScreen.dart';
import 'package:git_app/ui/screens/SearchScreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GitApp());
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
          CORE_SCREEN: (context) => CoreScreen(),
        });
  }
}
