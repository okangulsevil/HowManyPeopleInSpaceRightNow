import 'dart:convert';

import 'package:astronotapp/models/astronot.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Astronaut App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Astronot App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    // MainPage(),
    // NewsPage(),
    // PhotosPage(),
  ];

  void _onItemTapped(int index) {
    // setState(() {
    //   _selectedIndex = index;
    //   if (_selectedIndex == 0) {
    //     pageTitle = '#HowManyPeopleInSpaceRightNow?';
    //   } else if (_selectedIndex == 1) {
    //     pageTitle = '#NewsFromSpace';
    //   } else if (_selectedIndex == 2) {
    //     pageTitle = '#PhotosFromSpace';
    //   }
    // });
  }

  //APİ BURDA ÇAĞRILIYOR
  Future<Astro> getAstroApi() async {
    final response =
        await http.get(Uri.parse("http://api.open-notify.org/astros.json"));

    if (response.statusCode == 200) {
      return Astro.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load Astronots.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "#HowManyPeopleInSpaceRightNow?",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/earth.jpeg"), fit: BoxFit.cover)),
        child: FutureBuilder<Astro>(
          future: getAstroApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(100),
                      child: Text(snapshot.data!.number.toString(),
                          style: const TextStyle(
                              fontSize: 100, color: Colors.white)),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.people.length,
                        itemBuilder: (context, position) {
                          return ListTile(
                            title: Text(snapshot.data!.people[position].name,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center),
                            subtitle: Text(
                              snapshot.data!.people[position].craft,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Text("You have error.");
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Text("You have error. Are you APİ?");
            }
          },
        ),
      ),
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
            icon: Icon(Icons.label_important),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Photos',
          ),
        ],
        //currentIndex: _selectedIndex,

        //onTap: _onItemTapped,
      ),
    );
  }
}
