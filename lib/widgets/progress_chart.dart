import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fitness_app_riverpod/models/progress.dart';
import 'package:fitness_app_riverpod/providers/progress_provider.dart';

class ProgressChart extends ConsumerWidget {
  final String workoutId;
  final String exerciseId;

  const ProgressChart({
    super.key,
    required this.workoutId,
    required this.exerciseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progresses = ref.watch(progressProvider);
    final exerciseProgresses = progresses
        .where((progress) => progress.workoutId == workoutId)
        .expand((progress) => progress.exerciseProgresses)
        .where((exerciseProgress) => exerciseProgress.exerciseId == exerciseId)
        .toList();

    if (exerciseProgresses.isEmpty) {
      return const Center(
        child: Text('No progress data available'),
      );
    }

    final dates = exerciseProgresses.map((e) => e.timetaken.inSeconds.toDouble()).toList();
    final reps = exerciseProgresses.map((e) => e.repsCompleted.toDouble()).toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress Over Time',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= exerciseProgresses.length) {
                            return const SizedBox.shrink();
                          }
                          final date = exerciseProgresses[index].timetaken;
                          return Text(
                            DateFormat('MM/dd').format(DateTime.now().subtract(Duration(seconds: date.inSeconds))),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        exerciseProgresses.length,
                            (index) => FlSpot(index.toDouble(), reps[index]),
                      ),
                      color: Theme.of(context).primaryColor,
                      barWidth: 3,
                      isCurved: true,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: true, color: Colors.transparent),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Reps: ${exerciseProgresses.last.repsCompleted}'),
                Text('Time: ${exerciseProgresses.last.timetaken.inSeconds} sec'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}