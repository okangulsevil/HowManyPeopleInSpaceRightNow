import 'package:astronotapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Astronaut App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Astronot App'),
    );
  }
}
