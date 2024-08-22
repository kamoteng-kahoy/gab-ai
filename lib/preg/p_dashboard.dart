import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    // Add your pages here
    // Example: HomePage(),
    //         NotificationsPage(),
    //         ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            backgroundColor: SystemColors.bgColorLighter,
            leading: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage('https://avatar.iran.liara.run/public'), // Replace with the actual profile image URL
                ),
              ),
            ),
          ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            // Add your drawer items here
            // Example: ListTile(
            //           title: Text('Item 1'),
            //           onTap: () {
            //             // Handle item 1 tap
            //           },
            //         ),
            //         ListTile(
            //           title: Text('Item 2'),
            //           onTap: () {
            //             // Handle item 2 tap
            //           },
            //         ),
          ],
        ),
      ),

      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              TextGreetings(),
              SizedBox(height: 20.0),
              Carousel(),
              SizedBox(height: 40.0),
              SummaryAppointments(),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

class TextGreetings extends StatelessWidget {
  const TextGreetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Welcome to GAB-AI',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5.0),
          Text('Explore your nutrition journey with us.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentPage = 0;

  final List<Widget> _carouselItems = [
    Container(color: Colors.red),
    Container(color: Colors.green),
    Container(color: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _carouselItems,
          options: CarouselOptions(
            height: 200.0, // Adjust the height as needed
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10.0), // Add space between the carousel and the indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(_carouselItems.length, (int index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 10.0,
              width: (index == _currentPage) ? 20.0 : 10.0,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: (index == _currentPage) ? SystemColors.primaryColor : Colors.grey,
                borderRadius: BorderRadius.circular(5.0),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class SummaryAppointments extends StatelessWidget {
  const SummaryAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointments',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: SystemColors.primaryColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Darker shadow color
                spreadRadius: 1, // Slightly smaller spread radius
                blurRadius: 10, // Larger blur radius for a softer shadow
                offset: Offset(0, 4), // Offset to create a drop shadow effect
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage('https://avatar.iran.liara.run/public'),
                    radius: 20.0,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Name',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'Appointment Date and Time',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      print('pressed');
                      // Navigate to message screen
                      //Navigator.pushNamed(context, '/messageScreen');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ]
    );
  }
}