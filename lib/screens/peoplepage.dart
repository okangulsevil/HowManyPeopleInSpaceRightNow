import 'package:astronotapp/apis/astroapi.dart';
import 'package:astronotapp/models/astronot.dart';
import 'package:flutter/material.dart';

class AstroPage extends StatefulWidget {
  const AstroPage({Key? key}) : super(key: key);

  @override
  _AstroPageState createState() => _AstroPageState();
}

class _AstroPageState extends State<AstroPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/earth.jpeg"), fit: BoxFit.cover),
      ),
      child: FutureBuilder<Astro>(
        future: getAstroApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(40),
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
                                  fontSize: 25, color: Colors.white),
                              textAlign: TextAlign.center),
                          subtitle: Text(
                            "( ${snapshot.data!.people[position].craft} )",
                            style: const TextStyle(
                                fontSize: 17, color: Colors.white),
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
    );
  }
}
