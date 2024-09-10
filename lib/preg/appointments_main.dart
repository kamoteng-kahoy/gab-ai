import 'package:flutter/material.dart';

void main() {
  runApp(AppointmentScreen());
}

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: TabBar(
              indicator: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              tabs: [
                 SizedBox(
                  height: 45, // Set the desired height here
                  child: Tab(
                    icon: const Icon(Icons.home),
                    child: Container(
                      color: Colors.transparent, // Transparent background for unselected tabs
                    ),
                  ),
                ),
                SizedBox(
                  height: 45, // Set the desired height here
                  child: Tab(
                    icon: const Icon(Icons.search),
                    child: Container(
                      color: Colors.transparent, // Transparent background for unselected tabs
                    ),
                  ),
                ),
                SizedBox(
                  height: 45, // Set the desired height here
                  child: Tab(
                    icon: const Icon(Icons.settings),
                    child: Container(
                      color: Colors.transparent, // Transparent background for unselected tabs
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(child: Text('Tab 1')),
              Center(child: Text('Tab 2')),
              Center(child: Text('Tab 3')),
            ],
          ),
        ),
      ),
    );
  }
}