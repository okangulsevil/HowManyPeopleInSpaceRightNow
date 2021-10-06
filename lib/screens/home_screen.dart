import 'package:astronotapp/screens/peoplepage.dart';
import 'package:astronotapp/screens/photospage.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String pageTitle = '#HowManyPeopleAreInSpaceRightNow?';
  static const List<Widget> _widgetOptions = <Widget>[
    AstroPage(),
    PhotosPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        pageTitle = '#HowManyPeopleAreInSpaceRightNow?';
      } else if (_selectedIndex == 1) {
        pageTitle = '#PhotosFromSpace';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          pageTitle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF000000),
        selectedItemColor: const Color(0xFFFFFFFF),
        unselectedItemColor: const Color(0xB5FDFDFD),
        unselectedFontSize: 10,
        selectedFontSize: 15,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'How Many People Are in Space Right now?',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Photos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
