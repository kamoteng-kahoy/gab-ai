import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/booked_appointments.dart';
import 'package:gab_ai/preg/list_appointments.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: Column(
        children: [
          Container(
            width: 300,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.transparent, // Removes the line below the TabBar
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: SystemColors.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: SystemColors.textColorDarker,// Ensures no line is drawn
              tabs: [
                Tab(
                  child: Text(
                    'Available',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Booked',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AppointmentsList(),
                const BookedAppointments()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AppointmentScreen(),
  ));
}