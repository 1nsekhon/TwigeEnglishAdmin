import 'package:flutter/material.dart';
import 'package:twige/styles.dart';

bool showDets = false;

class ApprovedPage extends StatefulWidget {
  @override
  _ApprovedPageState createState() => _ApprovedPageState();
}

class _ApprovedPageState extends State<ApprovedPage> {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            // primary: false,
            padding: const EdgeInsets.fromLTRB(40, 20, 20, 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
            ),
            itemCount: accepted.length,
            itemBuilder: (context, index) {
              final upload = accepted[index];
              return GestureDetector(
                // onTap: () => uploadTap(index),
                child: upload,
              );
            },
          );
        },
      ),
    );
  }
}
