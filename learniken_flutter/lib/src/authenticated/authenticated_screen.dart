import 'package:flutter/material.dart';
import 'package:learniken_flutter/src/profile/profile_screen.dart';
import 'package:learniken_flutter/src/learniken/learniken_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticatedScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthenticatedScreen({super.key});

  @override
  AuthenticatedScreenState createState() => AuthenticatedScreenState();
}

class AuthenticatedScreenState extends State<AuthenticatedScreen> {
  // Startskjerm etter login er 0, altså profile
  int _currentIndex = 0;

  // Liste av skjermene i nav bar
  final List<Widget> _screens = const [
    ProfileScreen(),
    LearnikenScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? AppLocalizations.of(context)!.profile
              : AppLocalizations.of(context)!.learniken,
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Learniken',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
