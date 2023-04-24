import 'package:flutter/material.dart';
import 'package:twige/styles.dart';

class UploadsPage extends StatefulWidget {
  @override
  _UploadsPageState createState() => _UploadsPageState();
}

class _UploadsPageState extends State<UploadsPage> {
// class PicsPage extends StatelessWidget {
  List<Upload> uploads = [
    Upload(),
    Upload(),
    Upload(),
    Upload(),
    Upload(),
    Upload()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: secondaryColor,
          centerTitle: false,
          leading: SizedBox(width: 60),
          title: Text('Pending Uploads',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: whiteColor,
              )),
        ),
        body: GridView.builder(
          // primary: false,
          padding: const EdgeInsets.fromLTRB(60, 20, 60, 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 4,
          ),
          itemCount: uploads.length,
          itemBuilder: (context, index) {
            final upload = uploads[index];

            return upload;
          },
        )
        // gridDelegate: gridDelegate, itemBuilder: itemBuilder));
        );
  }
}

// var appState = context.watch<MyAppState>();
//var picRequests = filler[];

// if (appState.favorites.isEmpty) {
//   return Center(
//     child: Text('No favorites yet.'),
//   );
// }
// return ListView(
//   children: [
//     Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Text('${appState.favorites.length} favorites:'),
//     ),
//     for (var pair in appState.favorites)
//       ListTile(
//         leading: Icon(Icons.favorite),
//         title: Text(pair.asLowerCase),
//       ),
//   ],
//Pictionary upload requests
// );

class Upload extends StatelessWidget {
  String def = 'no definition';
  String source =
      'https://t4.ftcdn.net/jpg/03/16/68/69/360_F_316686992_OvCTP1wfazJhBeMrBBDUGooufSmj2O8G.jpg';

  // Upload({required def, required source});
// }

// class PicPrev extends Upload {
// PicPrev({required super.def, required super.source});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(),
        ),
        child: Image(image: NetworkImage(source)));
  }
}
