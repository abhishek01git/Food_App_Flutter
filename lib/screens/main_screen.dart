import 'package:flutter/material.dart';
import 'package:food_api/screens/foods.dart';
import 'package:food_api/screens/home.dart';
import 'package:food_api/screens/users.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const FoodsScreen(),
    const UsersScreen(),
  ];
  List<String> titles = ['Home Screen', 'Menu', 'Popular Users'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Text(titles[selectedIndex]),
        centerTitle: true,
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) => setState(() => selectedIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'FOODS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'USERS',
          ),
        ],
      ),
    );
  }
}
