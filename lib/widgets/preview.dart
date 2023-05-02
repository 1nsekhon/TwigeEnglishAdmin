import 'package:flutter/material.dart';
import 'upload.dart';

class Preview extends Upload {
  Preview(
      {required super.english, required super.kinyar, required super.source});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(image: NetworkImage(super.source)),
          Text(
            super.kinyar,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            super.english,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
