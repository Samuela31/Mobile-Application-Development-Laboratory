import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String displayText = 'Hello, Flutter';

  void changeText() {
    setState(() {
      displayText = 'Welcome to State Management';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('State Management Example'),
      ),
      body: GestureDetector(
        onTap: changeText, // Call changeText() when tapped
        child: Center(
          child: Text(
            displayText, // Display the dynamic text
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
