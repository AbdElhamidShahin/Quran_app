import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildLoadingShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: List.generate(4, (index) => _buildShimmerItem(index)),
      ),
    ),
  );
}

Widget _buildShimmerItem(int index) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Placeholder for header
        Container(
          width: 120,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        const SizedBox(height: 12),
        // Placeholder for content
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // Placeholder for footer
        if (index % 2 == 0) ...[
          const SizedBox(height: 12),
          Container(
            width: 200,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ],
    ),
  );
}
