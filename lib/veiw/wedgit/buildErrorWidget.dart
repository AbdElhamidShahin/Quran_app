import 'package:flutter/material.dart';

Widget buildErrorWidget(String error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 16),
        Text('Error loading content',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            )),
        const SizedBox(height: 8),
        Text(error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            )),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Implement retry logic if needed
          },
          child: const Text('Try Again'),
        ),
      ],
    ),
  );
}
