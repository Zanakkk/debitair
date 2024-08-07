import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class DebitData {
  final String date;
  final double debit;
  final String time;
  final int kran;

  DebitData({
    required this.date,
    required this.debit,
    required this.time,
    required this.kran,
  });

  factory DebitData.fromJson(Map<String, dynamic> json) {
    return DebitData(
      date: json['date'] as String,
      debit: double.parse(json['debit'].toString()), // Parse debit as double
      time: json['time'] as String,
      kran: int.parse(json['kran'].toString()), // Parse kran as int
    );
  }
}

class Pikshit extends StatefulWidget {
  const Pikshit({super.key});

  @override
  State<Pikshit> createState() => _PikshitState();
}

class _PikshitState extends State<Pikshit> {
  List<DebitData> dataair = [];
  double totalDebit = 0.0;
  List<double> debitByMonthGlobal = List.filled(12, 0);
  List<List<double>> debitByKranAndMonth =
  List.generate(5, (_) => List.filled(12, 0.0));

  @override
  void initState() {
    super.initState();
    fetchData(); // fetch data immediately on init
    Timer.periodic(const Duration(seconds: 30), (Timer t) => fetchData());
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
        'https://projectkranair-default-rtdb.asia-southeast1.firebasedatabase.app/air.json',
      ),
    );

    if (response.statusCode == 200) {
      // Parsing JSON
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      setState(() {
        dataair = responseData.values.map((entry) {
          return DebitData.fromJson(entry);
        }).toList();

        // Reset total debit per month
        debitByMonthGlobal = List.filled(12, 0);

        // Reset debitByKranAndMonth
        debitByKranAndMonth = List.generate(5, (_) => List.filled(12, 0.0));

        // Grouping data by month and kran
        for (var entry in dataair) {
          final month = int.parse(entry.date.split('-')[1]) - 1; // adjust parsing based on your date format
          final kran = entry.kran - 1; // Adjusting kran index to start from 0
          debitByMonthGlobal[month] += entry.debit;
          debitByKranAndMonth[kran][month] += entry.debit;
        }

        // Calculate total debit for all months
        totalDebit = debitByMonthGlobal.reduce((a, b) => a + b);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Data'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: dataair.length,
                    itemBuilder: (context, index) {
                      final item = dataair[index];
                      return ListTile(
                        title: Text('Kran: ${item.kran}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${item.date}'),
                            Text('Debit: ${item.debit.toStringAsFixed(2)}'), // Display debit with two decimal places
                            Text('Time: ${item.time}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jumlah dalam 6 bulan : ${totalDebit.toStringAsFixed(2)}'),
                      Text('Prediksi 6 bulan kedepan : ${(totalDebit * 0.9).toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // karena ada 5 kran
              itemBuilder: (context, kranIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pemakaian kran ${kranIndex + 1} per bulan:'),
                    const SizedBox(height: 8), // spasi antara judul dan chart
                    SizedBox(
                      height: 400,
                      width: 400,
                      child: LineChartSample1(
                          data: debitByKranAndMonth[kranIndex]),
                    ),
                    const SizedBox(height: 16), // spasi antara setiap kran
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LineChartSample1 extends StatelessWidget {
  const LineChartSample1({required this.data, super.key});
  final List<double> data;
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: data.length.toDouble(),
        minY: 0,
        maxY: data.reduce((curr, next) => curr > next ? curr : next) * 1.2,
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 1),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              data.length,
                  (index) => FlSpot(index.toDouble(), data[index]),
            ),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
