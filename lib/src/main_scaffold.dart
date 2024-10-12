import 'package:flutter/material.dart';

import 'features/places/ui/pages/place_list_page.dart';
import 'features/search/ui/pages/search_page.dart';
import 'features/settings/ui/pages/settings_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // List over different pages for menu choices
  final List<Widget> _pages = const [
    PlaceListPage(),
    SearchPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotly'), // The app's name
        backgroundColor: Colors.grey[900], // Dark background
        centerTitle: true, // Centers the title
        titleTextStyle: const TextStyle(
          color: Colors.white, // White text colour
          fontSize: 24, // Text font
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _pages[_selectedIndex], // Show chosen page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
