import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tonveto/views/screens/home.dart';
import 'package:tonveto/views/screens/pet/pets_screen.dart';
import 'package:tonveto/views/screens/profile/profile_screen.dart';

import '../../config/theme.dart';

class MainScreen extends StatefulWidget {
  static const route = "/main_screen";

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        // type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.mainColor,
        unselectedItemColor: Colors.grey,
        // selectedFontSize: 12.0,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: Text(
              'Home',
              style: const TextStyle(fontSize: 12),
            ),
            // label: textLocals.home,
          ),
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              'assets/icons/pets.svg',
              width: 25,
              color: _currentIndex == 1 ? AppTheme.mainColor : Colors.grey,
            ),
            title: Text(
              'Pets',
              style: const TextStyle(fontSize: 12),
            ),
            // label: textLocals.search,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_circle_outline),
            title: Text(
              'Rendez vous',
              style: const TextStyle(fontSize: 12),
            ),
            // label: textLocals.vendre,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.email_outlined),
            title: Text(
              'chat bot',
              style: const TextStyle(fontSize: 12),
            ),
            // label: textLocals.messages,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outlined),
            title: Text(
              'Profile',
              style: const TextStyle(fontSize: 12),
            ),
            // label: textLocals.profil,
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() => _currentIndex = index);
        },
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            IndexedStack(
              index: _currentIndex,
              children: const [
                Home(),
                PetsScreen(),
                Home(),
                Home(),
                ProfileScreen(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
