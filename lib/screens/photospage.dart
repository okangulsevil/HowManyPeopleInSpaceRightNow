import 'package:astronotapp/apis/photosapi.dart';
import 'package:astronotapp/models/photos.dart';
import 'package:flutter/material.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  late Future<List<DailyPhoto>> futurePhoto;

  @override
  void initState() {
    super.initState();
    futurePhoto = fetchDailyPhoto();
  }

  @override
  Widget build(BuildContext context) {
    var titleStyles = const TextStyle(fontSize: 25, color: Colors.white);
    var subtitle = const TextStyle(fontSize: 15, color: Colors.white);
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: FutureBuilder<List<DailyPhoto>>(
        future: futurePhoto,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(1),
              child: Column(
                children: [
                  Text(
                    snapshot.data![0].title.toString(),
                    style: titleStyles,
                    textAlign: TextAlign.center,
                  ),
                  Text('\n Date:' + snapshot.data![0].date.toString(),
                      style: subtitle),
                  Image.network(snapshot.data![0].url),
                  Text(
                    snapshot.data![0].explanation.toString(),
                    style: subtitle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}',
                style: const TextStyle(fontSize: 20, color: Colors.white));
          }
          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
