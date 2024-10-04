import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/appointments/booked_appointments.dart';
import 'package:gab_ai/preg/appointments/list_appointments.dart';

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
            decoration: BoxDecoration(
              color: Colors.grey[200], // Light grey background for inactive tab
              borderRadius: BorderRadius.circular(15),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: SystemColors.primaryColorDarker,
                borderRadius: BorderRadius.circular(15),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white, // Active tab text color
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
              ),
              unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
              ),
              unselectedLabelColor: Colors.black, // Inactive tab text color
              tabs: const [
                Tab(
                  child: Text(
                    'Available',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Booked',
                    style: TextStyle(
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
  runApp(const MaterialApp(
    home: AppointmentScreen(),
  ));
}