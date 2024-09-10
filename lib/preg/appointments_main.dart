import 'package:flutter/material.dart';

void main() {
  runApp(AppointmentScreen());
}

class AppointmentScreen extends StatelessWidget {
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
                 Container(
                  height: 45, // Set the desired height here
                  child: Tab(
                    icon: Icon(Icons.home),
                    child: Container(
                      color: Colors.transparent, // Transparent background for unselected tabs
                    ),
                  ),
                ),
                Container(
                  height: 45, // Set the desired height here
                  child: Tab(
                    icon: Icon(Icons.search),
                    child: Container(
                      color: Colors.transparent, // Transparent background for unselected tabs
                    ),
                  ),
                ),
                Container(
                  height: 45, // Set the desired height here
                  child: Tab(
                    icon: Icon(Icons.settings),
                    child: Container(
                      color: Colors.transparent, // Transparent background for unselected tabs
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
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