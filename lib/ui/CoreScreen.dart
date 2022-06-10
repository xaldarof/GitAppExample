import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:git_app/ui/screens/FavoritesScreen.dart';
import 'package:git_app/ui/screens/SearchScreen.dart';

class CoreScreen extends StatefulWidget {
  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  final screens = [SearchScreen(), FavoritesScreen()];

  var currentItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentItem],
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 4),
              ]),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: BottomNavigationBar(
                currentIndex: currentItem,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blue,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: "Search"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favorites"),
                ],
                onTap: (index) {
                  setState(() {
                    currentItem = index;
                  });
                },
              )),
        ));
  }
}
