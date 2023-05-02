import 'package:flutter/material.dart';
import 'package:twige/styles.dart';

class Upload extends StatefulWidget {
  final String english;
  final String kinyar;
  final String source;

  Upload({
    required this.english,
    required this.kinyar,
    required this.source,
  });

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
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
          Image(fit: BoxFit.fill, image: NetworkImage(widget.source)),
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
    );
  }
}

// class _UploadState extends State<Upload> {
//   bool approved = false;

//   void toggleOptions() {
//     setState(() {
//       widget.showOptions = !widget.showOptions;
//     });
//   }

//   void _handleApprove() {
//     print('approved photo');
//     toggleOptions();
//     accepted.add(widget);
//     setState(() {
//       widget.approved = true;
//       // accepted.add(widget);
//     });
//     print(accepted);
//   }

//   void _handleReject() {
//     print('rejected photo');
//     toggleOptions();
//     setState(() {
//       uploads.remove(widget);
//       widget.rejected = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.approved == false && widget.rejected == false) {
//       return GestureDetector(
//         onTap: () => toggleOptions(),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(5),
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: tileHoverColor,
//                 border: Border.all(
//                   color: secondaryColor,
//                   width: 3,
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Image(image: NetworkImage(widget.source)),
//                   Text(
//                     widget.kinyar,
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                   Text(
//                     widget.english,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (widget.showOptions)
//               Container(
//                 decoration: BoxDecoration(
//                     color: secondaryColor.withOpacity(.75),
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 height: 50,
//                 width: 150,
//                 alignment: Alignment.center,
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       GestureDetector(
//                         onTap: () => _handleApprove(),
//                         child: Icon(
//                           Icons.check_circle,
//                           color: Colors.green,
//                           size: 40,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => _handleReject(),
//                         child: Icon(
//                           Icons.delete_forever_rounded,
//                           color: Colors.red,
//                           size: 40,
//                         ),
//                       ),
//                     ]),
//               ),
//           ],
//         ),
//       );
//     } else {
//       return SizedBox();
//     }
//   }
// }
