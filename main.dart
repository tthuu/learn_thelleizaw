import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'facility_screen.dart';
import 'library_resources_screen.dart';
import 'survey_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Project',
      theme: ThemeData(
        // to share colors, font styles, icons
        primarySwatch: Colors.indigo,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _currentDateTime = '';
  String bookingStatus = '';
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //ensures that any initialization logic in the base class State is executed
    _currentDateTime =
        DateFormat('dd-MM-yyyy – hh:mm a').format(DateTime.now());
  }

  void updateBookingStatus(String status) {
    setState(() {
      bookingStatus = status;
    });
  }

  void clearInputs() {
    setState(() {
      nameController.clear();
      emailController.clear();
    });
  }

  void navigateToScreen(Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ).then((status) {
      if (status != null) {
        updateBookingStatus(status);
        clearInputs();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NP Facility Booking S10245698B'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Date & Time(SGT): $_currentDateTime',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            Image.asset('images/img.png', height: 300),
            const Text(
              'You can refer to our NP map for location of our facilities.',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                navigateToScreen(
                  FacilityListScreen(
                    title: 'Sports and Arts Facilities S10245698B',
                    facilities: [
                      'Badminton Court (Blk 16, Blk 20)',
                      'Table Tennis (Blk 16)',
                      'Squash Court (Blk 16)',
                      'Tennis Court (Blk 22)',
                      'Dance Room (Blk 73)',
                      'Swimming Pools',
                    ],
                    name: nameController.text,
                    email: emailController.text,
                  ),
                );
              },
              child: const Text(
                'Sports and Arts Facilities',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 6),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                navigateToScreen(
                  LibraryResourcesScreen(
                    name: nameController.text,
                    email: emailController.text,
                  ),
                );
              },
              child: const Text(
                'Library Resources',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 6),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                navigateToScreen(SurveyScreen());
              },
              child: const Text(
                'Help us to survey',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
