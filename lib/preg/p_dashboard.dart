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
            backgroundColor: Colors.transparent,
            centerTitle: true,
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
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: const Icon(Icons.notifications_outlined),
              onSelected: (String result) {
                // Handle notification selection
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Notification 1',
                  child: Text('Notification 1'),
                ),
                const PopupMenuItem<String>(
                  value: 'Notification 2',
                  child: Text('Notification 2'),
                ),
                const PopupMenuItem<String>(
                  value: 'Notification 3',
                  child: Text('Notification 3'),
                ),
                // Add more notifications here
              ],
            ),
          ],
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const TextGreetings(),
              const SizedBox(height: 40.0),
              const Carousel(),
              const SizedBox(height: 40.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Appointments',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Appointments(),
              const SizedBox(height: 40.0),
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
              fontSize: 30,
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
    Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            SystemColors.secondaryColor,
            SystemColors.accentColor2,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(25)
      ),
    ),
    Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            SystemColors.secondaryColor,
            SystemColors.accentColor2,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(25)
      ),
    ),
    Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            SystemColors.secondaryColor,
            SystemColors.accentColor2,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(25)
      ),
    ),
    Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            SystemColors.secondaryColor,
            SystemColors.accentColor2,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(25)
      ),
    ),
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
            autoPlayInterval: const Duration(seconds: 10),
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
              duration: const Duration(milliseconds: 400),
              height: 8.0,
              width: (index == _currentPage) ? 20.0 : 10.0,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
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

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final List<Map<String, String>> _appointments = [
    {
      'name': 'John Doe',
      'profilePicture': 'https://avatar.iran.liara.run/public',
      'timeDate': '2023-10-01 10:00 AM',
    },
  ];

  void _addAppointment(Map<String, String> appointment) {
    if (_appointments.length < 5) {
      setState(() {
        _appointments.add(appointment);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _appointments.length,
      itemBuilder: (context, index) {
        final appointment = _appointments[index];
        return SizedBox(
          height: 100,
          child: Card(
            color: SystemColors.bgWhite,
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(appointment['profilePicture']!),
                ),
                title: Text(appointment['name']!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(appointment['timeDate']!),
                trailing: IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {
                    // Handle message button press
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}