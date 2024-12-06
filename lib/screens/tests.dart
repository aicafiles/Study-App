import 'package:flutter/material.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Practice Tests"),
      ),
      body: const Center(
        child: Text(
          "This is the Practice Tests Screen.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
