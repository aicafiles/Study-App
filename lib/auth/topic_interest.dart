import 'package:flutter/material.dart';
import '../screens/home.dart';

class TopicInterestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Your Interests")),
      body: Column(
        children: [
          CheckboxListTile(
            title: Text("Mathematics"),
            subtitle: Text("Geometry, Algorithm"),
            value: true,
            onChanged: (val) {},
          ),
          CheckboxListTile(
            title: Text("Economy"),
            subtitle: Text("Stock, Property, News"),
            value: false,
            onChanged: (val) {},
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}
