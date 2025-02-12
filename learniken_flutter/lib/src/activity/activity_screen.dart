import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  static const routeName = '/activity';
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Aktivitetsside',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
