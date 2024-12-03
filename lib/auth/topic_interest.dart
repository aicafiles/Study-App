import 'package:flutter/material.dart';
import '../screens/home.dart';

class TopicInterestScreen extends StatefulWidget {
  const TopicInterestScreen({super.key});

  @override
  _TopicInterestScreenState createState() => _TopicInterestScreenState();
}

class _TopicInterestScreenState extends State<TopicInterestScreen> {
  bool isMathematicsChecked = false;
  bool isEconomyChecked = false;
  bool isEnglishChecked = false;
  bool isBiologyChecked = false;
  bool isGeographyChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Choose your topic interest',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Lorem ipsum blah blah blah, blahblah blahblahblah. Blah, Blah, Blah, Blah. Blah.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757575),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  CheckboxListTile(
                    title: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF8BBD0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.calculate,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Mathematics',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    subtitle: const Text(
                      'Blah, Blah, Blah, Blah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                    value: isMathematicsChecked,
                    onChanged: (val) {
                      setState(() {
                        isMathematicsChecked = val!;
                      });
                    },
                  ),

                  CheckboxListTile(
                    title: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF59D),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.trending_up,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Economy',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    subtitle: const Text(
                      'Blah, Blah, Blah, Blah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                    value: isEconomyChecked,
                    onChanged: (val) {
                      setState(() {
                        isEconomyChecked = val!;
                      });
                    },
                  ),

                  CheckboxListTile(
                    title: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF90CAF9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.book,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'English',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    subtitle: const Text(
                      'Blah, Blah, Blah, Blah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                    value: isEnglishChecked,
                    onChanged: (val) {
                      setState(() {
                        isEnglishChecked = val!;
                      });
                    },
                  ),

                  CheckboxListTile(
                    title: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFA5D6A7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.spa,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Biology',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    subtitle: const Text(
                      'Blah, Blah, Blah, Blah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                    value: isBiologyChecked,
                    onChanged: (val) {
                      setState(() {
                        isBiologyChecked = val!;
                      });
                    },
                  ),

                  CheckboxListTile(
                    title: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF81C784),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.public,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Geography',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    subtitle: const Text(
                      'Blah, Blah, Blah, Blah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                    value: isGeographyChecked,
                    onChanged: (val) {
                      setState(() {
                        isGeographyChecked = val!;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF42A5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
