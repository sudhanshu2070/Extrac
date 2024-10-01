import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'calendar_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'add_expense_button.dart';
import 'dart:ui' as ui;


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF2E2F45), // Deep Navy Gray for the AppBar
        foregroundColor: Colors.white, // Change the color of the back button to white
        titleTextStyle: TextStyle(
          // color: Colors.white, // Set title color to white for better visibility
          fontSize: 21.5, // You can adjust the font size as needed
          fontWeight: FontWeight.normal, // Optional: make the title bold
          foreground: Paint()
            ..shader = ui.Gradient.linear(
              const Offset(0, 35),
              const Offset(160, 50),
              <Color>[
                Colors.white,
                Colors.blueGrey,
              ],
            ),
        ),
          actions: [
            // Human face icon in the top right corner
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Show the pop-up menu when the face icon is clicked
                _showPopupMenu(context);
              },
            ),
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5), // Light Gray background for the section
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
              child: _buildTotalBalanceSection(),
            ),
            const SizedBox(height: 5),
            _buildAnalyticsSection(context),
            const SizedBox(height: 5),
            _buildLastTransactionsSection(context),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: const AddExpenseButton(), // Custom floating button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Position like in the image
    );
  }


// Function to display the popup menu
  void _showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 0, 0), // Top right corner
      items: [
        const PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person),
              SizedBox(width: 8),
              Text('Profile'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'calendar',
          child: Row(
            children: [
              Icon(Icons.calendar_today),
              SizedBox(width: 8),
              Text('Calendar'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout),
              SizedBox(width: 8),
              Text('Logout'),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      // Handle actions based on the selected option
      if (value == 'profile') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      } else if (value == 'calendar') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CalendarScreen()),
        );
      } else if (value == 'logout') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }


  Widget _buildTotalBalanceSection() {
    double totalBalance = 123478.00;

    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: const Color(0xFF00A8E8), // Cool Blue for the balance section background
        borderRadius: BorderRadius.circular(12.0), // Curved edges for the card
      ),
      child: Center(
        child: Text(
          'Total Balance: \$${totalBalance.toStringAsFixed(2)} Mn',
          style: const TextStyle(
            color: Colors.white, // White text to contrast with the blue background
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Light Gray background for the section
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with title and button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Analytics',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  // color: const Color(0xFF2E2F45), // Deep Navy Gray for text
                  fontWeight: FontWeight.bold, // Make text bold
                  fontSize: 23,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                      const Offset(0, 35),
                      const Offset(150, 20),
                      <Color>[
                        Colors.grey,
                        Colors.blueGrey,
                      ],
                    ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/detail');
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF00A8E8), // Cool Blue for the button text
                ),
                child: const Text('Details'),
              ),
            ],
          ),
          const SizedBox(height: 10), // Reduced gap
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
                        color: Color(0xFF68737D),
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
                              color: Color(0xFF68737D),
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
                        color: Color(0xFF68737D),
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
                              color: Color(0xFF68737D),
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
        ],
      ),
    );
  }

  List<BarChartGroupData> _generateBarChartGroups() {
    return List.generate(
      6,
          (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (index + 1) * 150,
            color: const Color(0xFF00A8E8), // Cool Blue for the bars
            width: 16,
            borderRadius: BorderRadius.circular(8), // Smooth out the bar edges
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
      {'amount': 70.0, 'category': 'things', 'date': '2024-09-10'},
      {'amount': 70.0, 'category': 'things', 'date': '2024-09-10'},
      {'amount': 70.0, 'category': 'things', 'date': '2024-09-10'},
      {'amount': 70.0, 'category': 'things', 'date': '2024-09-10'},
      {'amount': 70.0, 'category': 'things', 'date': '2024-09-10'},
      {'amount': 100.0, 'category': 'things', 'date': '2024-09-10'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Light Gray background for the section
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last Transactions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              // color: const Color(0xFF2E2F45), // Deep Navy Gray for text
              fontWeight: FontWeight.bold,
              fontSize: 23,
              foreground: Paint()
                ..shader = ui.Gradient.linear(
                  const Offset(0, 35),
                  const Offset(150, 20),
                  <Color>[
                    Colors.grey,
                    Colors.blueGrey,
                  ],
                ),
            ),
          ),
          const SizedBox(height: 10),
          // Use SingleChildScrollView with a limited height for the transactions
          SizedBox(
            height: 365, // Set a fixed height for the scrollable area
            child: SingleChildScrollView(
              child: Column(
                children: transactions.map((transaction) => ListTile(
                  leading: const Icon(Icons.currency_rupee_outlined, color: Color(0xFF2E2F45)), // Icon with Navy Gray color
                  title: Text('${transaction['amount']} - ${transaction['category']}',
                      style: const TextStyle(color: Color(0xFF4A4A4A))), // Muted Gray for the list item text
                  subtitle: Text('${transaction['date']}',
                      style: const TextStyle(color: Color(0xFF68737D))), // Muted subtitle text color
                  // tileColor: const Color(0xFFFFFFFF), // White background for list items
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Curved edges for the list tile
                  ),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

