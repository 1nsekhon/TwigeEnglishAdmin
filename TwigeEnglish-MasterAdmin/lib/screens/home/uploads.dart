import 'package:flutter/material.dart';
import 'package:twige/main.dart';
import 'package:twige/styles.dart';

bool showDets = false;

class UploadsPage extends StatefulWidget {
  @override
  _UploadsPageState createState() => _UploadsPageState();
}

class _UploadsPageState extends State<UploadsPage> {
  @override
  Widget build(BuildContext context) {
    void uploadTap(int index) {
      uploads[index].showOptions = !uploads[index].showOptions;
      print('$index');
      uploads.removeAt(index);
    }

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
        body: LayoutBuilder(builder: (context, constraints) {
          return GridView.builder(
            // primary: false,
            padding: const EdgeInsets.fromLTRB(40, 20, 20, 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
            ),
            itemCount: uploads.length,
            itemBuilder: (context, index) {
              final upload = uploads[index];

              return GestureDetector(
                onTap: () => uploadTap(index),
                child: upload,
              );
              // child: Container(
              //   width: 100,
              //   height: 100,
              //   color: whiteColor,
              // ));

              //       toggleApprove
              //           ? Container(
              //               height: 50,
              //               width: 150,
              //               alignment: Alignment.center,
              //               color: secondaryColor.withOpacity(.70),
              //               child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                   children: [
              //                     Icon(Icons.check_circle),
              //                     Icon(Icons.delete_forever_rounded),
              //                   ]))
              //           : SizedBox(),
              //     ],
              //   ),
              // );
            },
          );
        }));
  }
}

// class UploadWrapper extends StatefulWidget {
//   final Upload upload;

// }

class Upload extends StatefulWidget {
  final String english;
  final String kinyar;
  final String source;
  late bool showOptions = false;

  Upload({
    required this.english,
    required this.kinyar,
    required this.source,
  });

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  // bool _showOptions = false;

  void toggleOptions() {
    setState(() {
      // _showOptions = !_showOptions;
      widget.showOptions = !widget.showOptions;
    });
    print(widget);
    print(widget.showOptions);
  }

  void _handleApprove() {
    print('approved photo');
    toggleOptions();
    setState(() {});
  }

  void _handleReject() {
    print('rejected photo');
    toggleOptions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleOptions(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: tileHoverColor,
              border: Border.all(
                color: secondaryColor,
                width: 3,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(image: NetworkImage(widget.source)),
                Text(
                  widget.kinyar,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.english,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // if (_showOptions)
          if (widget.showOptions)
            Container(
              decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(.75),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 50,
              width: 150,
              alignment: Alignment.center,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => _handleApprove(),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _handleReject(),
                      child: Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ]),
            ),
        ],
      ),
    );
  }
}
