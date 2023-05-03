import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:twige/services/database_manager.dart';
import 'package:twige/styles.dart';
import '../../models/firebase_file.dart';
import '../../widgets/upload.dart';

bool showDets = false;

class UploadsPage extends StatefulWidget {
  @override
  _UploadsPageState createState() => _UploadsPageState();
}

class _UploadsPageState extends State<UploadsPage> {

  late Future<List<FirebaseFile>> futureFiles;
  var files;

  @override

  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAllUnapproved();
  }

  @override
  

  bool _showOverlay = false;
  String _english = 'default english';
  String _kinyar = 'default kinyar';
  String _source = 'some source';
  int _displayIndex = 0;

  void toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  void seeOptions(int index) {
    toggleOverlay();
    setState(() {
      _displayIndex = index;
      // ADD THESE ONCE CUSTOM METADATA IS ADDED
      //final uenglish = getEnglish(file);
      //final ukinyar = getKinyar(file);
      _source = files[index].url;
      _english = 'default english';
      _kinyar = 'default kinyar';
      // if (uploads[index].approved == true) {
      //   accepted.add(uploads[index]);
      //   uploads.removeAt(index);
      // }
      // if (uploads[index].rejected == true) {
      //   // print('$index');
      //   uploads.removeAt(index);
      // }
    });
    // print(accepted);
  }

  

  void _approve() {
    toggleOverlay();
    
    /* 
    MOVE FUNCTION 
    downloads from firebase
    uploads to firebase
    deletes locally stored photo 
    */
    Reference ref = FirebaseStorage.instance.refFromURL(files[_displayIndex].url);
    FirebaseApi.move(ref);

    // deletes from firebase
    FirebaseStorage.instance.refFromURL(files[_displayIndex].url).delete(); 
    
    super.setState(() {
      
      files.removeAt(_displayIndex);
    });
  }

  void _reject() {
    toggleOverlay();
    FirebaseStorage.instance.refFromURL(files[_displayIndex].url).delete(); // deletes from firebase

    super.setState(() {
      files.removeAt(_displayIndex);
    });
  }

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
      body: Stack(
        children: [
          FutureBuilder(
          future:futureFiles,
          builder: (context, snapshot){
            if(snapshot.hasError) {
              return const Center(child: Text('error has occured'));
            } 

            else if(snapshot.hasData) {
               files = snapshot.data!;
              
                return LayoutBuilder(builder: (context, constraints) {
                  return GridView.builder(
                  // primary: false,
              
                  padding: const EdgeInsets.fromLTRB(40, 20, 20, 0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
                  ),
                  itemCount:files.length,
                  itemBuilder: (context, index) {
                  final file = files[index]; // this contains object that contains url to source
                
                  // ADD THESE ONCE CUSTOM METADATA IS ADDED
                 //final uenglish = getEnglish(file);
                 //final ukinyar = getKinyar(file);
                  final uploadItem = 
                  Upload(
                  // ADD THESE ONCE CUSTOM METADATA IS ADDED
                  //english: uenglish, //filename which can also be the name of the item 
                  //kinyar: ukinyar,
                   english: 'sampleEnglish',
                   kinyar: 'sampleKinyar',
                   source: file.url
                 );
                
                    return GestureDetector(
                    onTap: () => seeOptions(index), // possibly not neccesary
                    child: uploadItem,
                   );
                 },
                 );
                });
            }
            return const Center(child: CircularProgressIndicator());
          }),
          if (_showOverlay)
            Center(
              child: Container(
                height: 500,
                width: 400,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tileHoverColor,
                  border: Border.all(
                    color: secondaryColor,
                    width: 3,
                  ),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: toggleOverlay, child: Icon(Icons.close))
                    ],
                  ),
                  Image(height: 300, width: 300, image: NetworkImage(_source)),
                  Text(
                    _kinyar,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    _english,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => _approve(),
                        child: Container(
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(), color: whiteColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.check,
                              size: 35,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _reject(),
                        child: Container(
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(), color: whiteColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              size: 35,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )
        ],
      ),
    );
  }
}
