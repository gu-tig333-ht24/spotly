// import 'package:flutter/material.dart';
// import 'bottom_tab.dart'; // Import BottomTab
// import '../../settings/ui/pages/settings_page.dart'; // Import SettingsPage
// import '../../../core/models/places_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

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
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> _savedPlaces = [];

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  // Ladda sparade platser från SharedPreferences
  Future<void> _loadPlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPlacesData = prefs.getStringList('places') ?? [];

    final List<Map<String, String>> loadedPlaces =
        savedPlacesData.map((placeData) {
      final placeParts = placeData.split('|');
      return {
        'title': placeParts[0],
        'imagePath': placeParts[1],
      };
    }).toList();

    setState(() {
      _savedPlaces = loadedPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Places'),
      ),
      body: _savedPlaces.isEmpty
          ? const Center(
              child: Text('No places added yet'),
            )
          : ListView.builder(
              itemCount: _savedPlaces.length,
              itemBuilder: (ctx, index) {
                final place = _savedPlaces[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: File(place['imagePath']!).existsSync()
                        ? FileImage(File(place['imagePath']!))
                        : null,
                    child: !File(place['imagePath']!).existsSync()
                        ? const Icon(Icons.image_not_supported)
                        : null,
                  ),
                  title: Text(place['title']!),
                );
              },
            ),
    );
  }
}
