import 'package:flutter/material.dart';

class LearnikenScreen extends StatelessWidget {
  static const routeName = '/learniken';
  const LearnikenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Learniken',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
