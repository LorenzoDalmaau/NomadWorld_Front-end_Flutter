import 'package:flutter/material.dart';
import 'package:nomadworld/ui/screens/CreateIL/create_il.dart';
import 'package:nomadworld/ui/screens/HomeScreen/home_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  int screenIndex = 1;
  List screensList = [
    const CreateIL(),
    HomeScreen(),
    //UserScreen
  ];

  void _onItemTapped(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: screenIndex,
        unselectedItemColor: Color(0xFF257155),
        selectedItemColor: Color(0xFF245c54),
        selectedIconTheme: IconThemeData(size: 40),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
