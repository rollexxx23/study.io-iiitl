import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:study.io/views/start.dart';
import '../services/auth.dart';
import './login.dart';
import './chatScreen.dart';
import './TodoScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> pages = [
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.grey,
    ),
    TodoScreen(),
    ChatScreen(),
  ];
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              AuthMethods().signOut().then((s) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Start()));
              });
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                )),
          )
        ],
        title: Text(
          "Study.io",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),

      //body: ListofColors[currentIndex],
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: pages,
        ),
      ),

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        curve: Curves.ease,
        backgroundColor: Colors.black,
        onItemSelected: (index) {
          setState(
            () {
              _currentIndex = index;
              _pageController.animateToPage(
                _currentIndex,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          );
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.class__rounded),
            title: Text('classes'),
            activeColor: Colors.red,
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.lock_clock),
            title: Text('To-Do'),
            activeColor: Colors.green,
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
            activeColor: Colors.blue,
            inactiveColor: Colors.white,
          ),
        ],
      ),

      // body: Center(
      //   child: Text(
      //     "Your Classes",
      //     style: TextStyle(
      //       fontSize: 40.0,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
    );
  }
}
