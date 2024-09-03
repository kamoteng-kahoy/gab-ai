import 'package:flutter/material.dart';

class MealPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Breakfast'),
                  Tab(text: 'Lunch'),
                  Tab(text: 'Snacks'),
                  Tab(text: 'Dinner'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        height: 500, // Replace with your desired height
                        child: Text('Tab 1 Content'),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: 500, // Replace with your desired height
                        child: Text('Tab 2 Content'),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: 500, // Replace with your desired height
                        child: Text('Tab 3 Content'),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: 500, // Replace with your desired height
                        child: Text('Tab 4 Content'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
