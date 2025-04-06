import 'package:flutter/material.dart';

Widget buildLoadingShimmer() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
      );
    },
  );
}
