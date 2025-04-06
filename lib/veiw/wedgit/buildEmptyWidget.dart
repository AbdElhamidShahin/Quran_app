import 'package:flutter/material.dart';

Widget buildEmptyWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.hourglass_empty, size: 48, color: Colors.blue),
        const SizedBox(height: 16),
        Text('No content available',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            )),
        const SizedBox(height: 8),
        Text('The requested Surah pages could not be found',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            )),
      ],
    ),
  );
}
