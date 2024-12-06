import 'package:flutter/material.dart';

class FlashcardsScreen extends StatelessWidget {
  const FlashcardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashcards"),
      ),
      body: const Center(
        child: Text(
          "This is the Flashcards Screen.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
