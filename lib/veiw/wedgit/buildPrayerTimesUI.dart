import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildPrayerTimesUI(
  Map<String, String> times,
  String nextPrayerName,
  Duration remainingTime,
) {
  final orderedPrayers = [
    {'name': 'العشاء', 'time': times['العشاء'] ?? '--:--'},
    {'name': 'المغرب', 'time': times['المغرب'] ?? '--:--'},
    {'name': 'العصر', 'time': times['العصر'] ?? '--:--'},
    {'name': 'الظهر', 'time': times['الظهر'] ?? '--:--'},
    {'name': 'الفجر', 'time': times['الفجر'] ?? '--:--'},
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'الوقت الحالي',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat('hh:mm a').format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'متبقي حتى صلاة $nextPrayerName',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  'الوقت المتبقي: ${remainingTime.inHours.toString().padLeft(2, '0')}:${(remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: orderedPrayers.length,
            itemBuilder: (context, index) {
              final prayer = orderedPrayers[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    prayer['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    prayer['time']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
