import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Notes"),
      ),
      body: const Center(
        child: Text(
          "This is the Study Notes Screen.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}