import 'package:flutter/material.dart';
import 'flashcards.dart';
import 'notes.dart';
import 'tests.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Hi, Name!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Here is your study progress today',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF757575),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 17),
              // Progress Cards
              Row(
                children: [
                  _buildProgressCard('89%', 'Flashcards', Colors.orange[300]!),
                  const SizedBox(width: 8),
                  _buildProgressCard('100%', 'Test Taken', Colors.blue[300]!),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildProgressCard('18', 'Study Notes', Colors.green[300]!),
                  const SizedBox(width: 8),
                  _buildProgressCard('12', 'Upcoming Tasks', Colors.red[300]!),
                ],
              ),
              const SizedBox(height: 24),
              // Quick Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _buildActionButton(
                      icon: Icons.book_outlined,
                      label: 'Flashcards',
                      color: Colors.teal[300]!,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FlashcardFoldersScreen()),
                        );
                      },
                    ),
                  ),
                  _buildActionButton(
                    icon: Icons.menu_book_outlined,
                    label: 'Notes',
                    color: Colors.blue[900]!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotesScreen()),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.task_alt_outlined,
                    label: 'Tests',
                    color: Colors.orange[700]!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TestsScreen()),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildActionButton(
                      icon: Icons.accessibility_new_outlined,
                      label: 'Accessibility',
                      color: Colors.green[700]!,
                      onPressed: () {
                        // Placeholder for future functionality
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Schedule Section
              const Text(
                'Schedule',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildScheduleTile('7', 'Economy', Colors.orange[200]!),
                    _buildScheduleTile('8', 'Geography', Colors.blue[200]!),
                    _buildScheduleTile('9', 'English', Colors.indigo[200]!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(String stat, String title, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stat,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, size: 28, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTile(String date, String subject, Color color) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subject,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}