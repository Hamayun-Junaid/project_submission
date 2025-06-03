import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodStatsScreen extends StatelessWidget {
  const MoodStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Stats'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('moods')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          final Map<String, int> moodCounts = {};
          for (var doc in docs) {
            moodCounts[doc['mood']] = (moodCounts[doc['mood']] ?? 0) + 1;
          }

          if (moodCounts.isEmpty) {
            return const Center(
              child: Text('No mood data to display.',
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
            );
          }

          final total = moodCounts.values.reduce((a, b) => a + b);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Your Mood Distribution',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 50,
                      sections: moodCounts.entries.map((entry) {
                        final percentage =
                            ((entry.value / total) * 100).toStringAsFixed(1);
                        return PieChartSectionData(
                          title: '${entry.key}\n$percentage%',
                          value: entry.value.toDouble(),
                          color: Colors.primaries[
                              moodCounts.keys.toList().indexOf(entry.key) %
                                  Colors.primaries.length],
                          radius: 80,
                          titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView(
                    children: moodCounts.entries.map((entry) {
                      final color = Colors.primaries[
                          moodCounts.keys.toList().indexOf(entry.key) %
                              Colors.primaries.length];
                      final percentage =
                          ((entry.value / total) * 100).toStringAsFixed(1);
                      return ListTile(
                        leading: CircleAvatar(backgroundColor: color),
                        title: Text(entry.key,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        trailing: Text('$percentage%',
                            style: const TextStyle(fontSize: 16)),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
