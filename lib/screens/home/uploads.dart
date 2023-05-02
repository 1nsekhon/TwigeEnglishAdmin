import 'package:flutter/material.dart';
import 'package:twige/styles.dart';

bool showDets = false;

class UploadsPage extends StatefulWidget {
  @override
  _UploadsPageState createState() => _UploadsPageState();
}

class _UploadsPageState extends State<UploadsPage> {
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
      _english = uploads[index].english;
      _kinyar = uploads[index].kinyar;
      _source = uploads[index].source;
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
    super.setState(() {
      accepted.add(uploads[_displayIndex]);
      uploads.removeAt(_displayIndex);
    });
  }

  void _reject() {
    toggleOverlay();
    super.setState(() {
      uploads.removeAt(_displayIndex);
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
          LayoutBuilder(builder: (context, constraints) {
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
                  onTap: () => seeOptions(index),
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
