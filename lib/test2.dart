// import 'package:flutter/material.dart';

// class TruncatedTextExample extends StatelessWidget {
//   final String longText = "abcdefghijklmn";

//   String truncateText(String text, double maxWidth, TextStyle style) {
//     // Create a TextPainter to measure the text
//     TextPainter textPainter = TextPainter(
//       text: TextSpan(text: text, style: style),
//       maxLines: 1,
//       textDirection: TextDirection.ltr,
//     )..layout(maxWidth: maxWidth);

//     // If the text fits, return it as-is
//     if (textPainter.didExceedMaxLines) {
//       // Truncate the text and add ".." until it fits
//       for (int i = text.length - 1; i > 0; i--) {
//         String truncatedText = text.substring(0, i) + "..";
//         textPainter.text = TextSpan(text: truncatedText, style: style);
//         textPainter.layout(maxWidth: maxWidth);

//         if (!textPainter.didExceedMaxLines) {
//           return truncatedText;
//         }
//       }
//     }
//     return text; // Return original text if it fits
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Truncated Text Example")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             // Screen width available for the text
//             double availableWidth = constraints.maxWidth;

//             // Define the text style
//             TextStyle textStyle = TextStyle(fontSize: 16);

//             // Get the truncated text
//             String truncated =
//                 truncateText(longText, availableWidth, textStyle);

//             return Column(
//               children: [
//                 Container(
//                   height: 100,
//                   width: 120,
//                   color: Colors.amber,
//                 ),
//                 Text(truncateText('aaaaanaaanaaanaanaaana', availableWidth,
//                     TextStyle(color: Colors.amber))),
//                 Text(
//                   truncated,
//                   style: textStyle,
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
