// import 'package:flutter/material.dart';
// import 'package:spotly/src/features/main/domain/bottom_tab.dart'; // Import BottomTab
// import 'package:spotly/src/features/places/providers/places.dart'; // Import PlacesScreen
// import 'package:spotly/src/features/settings/ui/pages/settings_page.dart'; // Import SettingsPage

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   BottomTab _currentTab = BottomTab.places;

//   void _onTabSelected(int index) {
//     setState(() {
//       _currentTab = BottomTab.fromIndex(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget content;

//     switch (_currentTab) {
//       case BottomTab.places:
//         content = const PlacesScreen();
//         break;
//       case BottomTab.search:
//         content = const Center(child: Text('Search Screen'));
//         break;
//       case BottomTab.settings:
//         content = const SettingsPage(); // Use SettingsPage here
//         break;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black, // Svart bakgrund
//         title: const Text(
//           'Spotly',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 24, // Stor textstorlek
//           ),
//         ),
//         centerTitle: true, // Centrera titeln
//       ),
//       body: content,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentTab.index,
//         onTap: _onTabSelected,
//         items: BottomTab.values.map((tab) {
//           return BottomNavigationBarItem(
//             icon: Icon(tab.icon),
//             label: tab.label,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:spotly/src/features/main/domain/bottom_tab.dart'; // Import BottomTab
import 'package:spotly/src/features/places/providers/places.dart'; // Import PlacesScreen
import 'package:spotly/src/features/settings/ui/pages/settings_page.dart'; // Import SettingsPage

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomTab _currentTab = BottomTab.places;

  void _onTabSelected(int index) {
    setState(() {
      _currentTab = BottomTab.fromIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (_currentTab) {
      case BottomTab.places:
        content = const PlacesScreen();
        break;
      case BottomTab.search:
        content = const Center(
          child: Text(
            'Search Screen',
            style: TextStyle(
              color: Colors.white, // Vit text
              fontSize: 20, // Valfri textstorlek
            ),
          ),
        );
        break;
      case BottomTab.settings:
        content = const SettingsPage(); // Use SettingsPage here
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 16, 16, 16), // Svart bakgrund
        title: const Text(
          'Spotly',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24, // Stor textstorlek
          ),
        ),
        centerTitle: true, // Centrera titeln
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab.index,
        onTap: _onTabSelected,
        selectedItemColor: const Color.fromARGB(
            255, 16, 16, 16), // Färgen på den valda ikonen och texten
        unselectedItemColor: const Color.fromARGB(
            255, 21, 20, 20), // Färgen på de icke-valda ikonerna och texterna
        showUnselectedLabels: true, // Visa texter för alla objekt
        items: BottomTab.values.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(tab.icon),
            label: tab.label,
          );
        }).toList(),
      ),
    );
  }
}
