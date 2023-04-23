import 'package:flutter/material.dart';


class UploadsPage extends StatefulWidget {
  @override
  _UploadsPageState createState() => _UploadsPageState();
}

class _UploadsPageState extends State<UploadsPage> {
// class PicsPage extends StatelessWidget {
  // List<String> uploads = List<String>(10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uploads Page'),
      ),
      drawer: DetailsDrawer(),
      // body: GridView.builder(
      // gridDelegate: gridDelegate, itemBuilder: itemBuilder));
    );
  }
}

class DetailsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('My App'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Option 1'),
            onTap: () {
              // Handle option 1
            },
          ),
          ListTile(
            title: Text('Option 2'),
            onTap: () {
              // Handle option 2
            },
          ),
        ],
      ),
    );
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
  }
}

class Photo {
  String identity =
      'https://t4.ftcdn.net/jpg/03/16/68/69/360_F_316686992_OvCTP1wfazJhBeMrBBDUGooufSmj2O8G.jpg';

  Photo();
}

class PicPrev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
      child: Image(
          image: NetworkImage(
              'https://t4.ftcdn.net/jpg/03/16/68/69/360_F_316686992_OvCTP1wfazJhBeMrBBDUGooufSmj2O8G.jpg')),
    );
  }
}
