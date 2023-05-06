//should we add remove pick functionality to here?

import 'package:flutter/material.dart';
import 'package:twige/services/database_manager.dart';
import 'package:twige/styles.dart';

import '../../models/firebase_file.dart';
import '../../widgets/upload.dart';

bool showDets = false;

class ApprovedPage extends StatefulWidget {
  @override
  _ApprovedPageState createState() => _ApprovedPageState();
}

class _ApprovedPageState extends State<ApprovedPage> {

  late Future<List<FirebaseFile>> futureFiles;
  var files;

  @override

  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAllApproved();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        centerTitle: false,
        leading: SizedBox(width: 60),
        title: Text('Approved Uploads',
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
                   english: file.english,
                   kinyar: file.english,
                   source: file.url
                 );
                
                    return GestureDetector(
                    //onTap: () => seeOptions(index), // possibly not neccesary
                    child: uploadItem,
                   );
                 },
                 );
                });
            }
            return const Center(child: CircularProgressIndicator());
          }),   
        ],
      ),
    );
  }
}
