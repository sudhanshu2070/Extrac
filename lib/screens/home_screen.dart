import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Ensure this is imported

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalBalanceSection(),
            const SizedBox(height: 20),
            _buildAnalyticsSection(context),
            const SizedBox(height: 20),
            _buildLastTransactionsSection(context),
            const Spacer(),
            _buildAddExpenseButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalBalanceSection() {
    double totalBalance = 1234.56;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Total Balance: \$${totalBalance.toStringAsFixed(2)}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analytics',
          style: Theme.of(context).textTheme.titleLarge, // Use headline6 for compatibility
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 1000,
              barGroups: _generateBarChartGroups(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  axisNameWidget: const Text(
                    'Amount',
                    style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  axisNameSize: 32,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toString(),
                          style: const TextStyle(
                            color: Color(0xff68737d),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: const Text(
                    'Month',
                    style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  axisNameSize: 32,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toString(),
                          style: const TextStyle(
                            color: Color(0xff68737d),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              barTouchData: BarTouchData(enabled: false),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/detail');
            },
            child: const Text('Details'),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _generateBarChartGroups() {
    return List.generate(
      6,
          (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (index + 1) * 150, // 'toY' instead of 'fromY'
            color: Colors.lightBlue, // Single color for simplicity
            width: 16,
            borderRadius: BorderRadius.zero, // Adjust if needed
          ),
        ],
      ),
    );
  }

  Widget _buildLastTransactionsSection(BuildContext context) {
    final transactions = [
      {'amount': 50.0, 'category': 'Food', 'date': '2024-09-01'},
      {'amount': 20.0, 'category': 'Transport', 'date': '2024-09-03'},
      {'amount': 75.0, 'category': 'Entertainment', 'date': '2024-09-05'},
      {'amount': 40.0, 'category': 'Utilities', 'date': '2024-09-10'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last Transactions',
          style: Theme.of(context).textTheme.titleLarge, // Use headline6 for compatibility
        ),
        const SizedBox(height: 10),
        ...transactions.map((transaction) => ListTile(
          leading: const Icon(Icons.attach_money),
          title: Text('${transaction['amount']} - ${transaction['category']}'),
          subtitle: Text('${transaction['date']}'),
        )),
      ],
    );
  }

  Widget _buildAddExpenseButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_expense');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text('Add Expense'),
      ),
    );
  }
}
