import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
              });
            },
            tooltip: "Jump to Today",
          ),
          // Wrap IconButton with Builder to get the right context
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context)
                      .openEndDrawer(); // Open right-side drawer
                },
              );
            },
          ),
        ],
      ),
      // Use endDrawer to make the drawer open from the right side
      endDrawer: _buildSideDrawer(context),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add logic to open event/task creation screen
        },
        tooltip: "Add Event/Task",
        child: const Icon(Icons.add),
      ),
    );
  }

  // Right-side drawer implementation
  Widget _buildSideDrawer(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.45, // 45% of screen width
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _getFlowerImage(), // Call the method to get the flower image
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Calendar Menu',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.view_week),
              title: const Text('Weekly View'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Weekly View
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Monthly View'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Monthly View
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Yearly View'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Yearly View
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Events'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Events
              },
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Tasks'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Tasks
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Settings
              },
            ),
          ],
        ),
      ),
    );
  }


  String _getFlowerImage() {
    // Get the current weekday (1 = Monday, 7 = Sunday)
    int dayOfWeek = DateTime.now().weekday;

    // Map weekday to corresponding flower image
    switch (dayOfWeek) {
      case 1:
        return 'assets/daily_flowers/flower_monday.png';
      case 2:
        return 'assets/daily_flowers/flower_tuesday.png';
      case 3:
        return 'assets/daily_flowers/flower_wednesday.png';
      case 4:
        return 'assets/daily_flowers/flower_thursday.png';
      case 5:
        return 'assets/daily_flowers/flower_friday.png';
      case 6:
        return 'assets/daily_flowers/flower_saturday.png';
      case 7:
        return 'assets/daily_flowers/flower_sunday.png';
      default:
        return 'assets/daily_flowers/flower_monday.png'; // Default image
    }
  }

}