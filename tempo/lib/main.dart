import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tempo/search.dart';
import 'analytics.dart';
import 'cards.dart';
import 'login.dart';
import 'globals.dart' as globals;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tempo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: globals.signedIn == false ? login() : navigator(),
    );
  }
}

class navigator extends StatefulWidget {

  @override
  navigatorState createState() => navigatorState();
}

class navigatorState extends State<navigator>{
  PageController _controller;
  var _selectedPageIndex;
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;
    _pages = [
      cardsHome(),
      analyticsHome(),
      searchHome(),
    ];

    _controller = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        controller: _controller,
        //disables scrolling left/right
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.cyan,
        height: 50,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.bounceInOut,
        index: _selectedPageIndex,
        items: <Widget> [
          Icon(Icons.open_with, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.search, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
            _controller.jumpToPage(index);
          });
        },
      ),
    );
  }
}
