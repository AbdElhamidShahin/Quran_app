import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerItem() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}