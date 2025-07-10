import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final TextStyle customTextStyle = TextStyle(
      fontSize: 40,
      color: Color.fromARGB(255, 56, 130, 228), // Set the foreground color here
      shadows: [
        Shadow(
          color: Colors.grey,
          blurRadius: 2.0,
          offset: Offset(2.0, 2.0),
        ),
      ],
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Shopping Center')),
        body: Center(
          child: Container(
            height: 250.0,
            width: 600.0,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                colors: [
                  Colors.indigo,
                  Colors.blueAccent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  offset: const Offset(2.0, 2.0),
                ),
              ],
            ),
            child: Center(
              child: Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    'Welcome to our Shop!',
                    style: TextStyle(
                      fontSize: 40,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Color.fromARGB(255, 209, 209, 209),
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    'Welcome to our Shop!',
                    style: customTextStyle, // Use the customTextStyle here
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: const [
              ListTile(leading: Icon(Icons.home), title: Text('Home')),
              ListTile(
                  leading: Icon(Icons.add_shopping_cart), title: Text('Cart')),
              ListTile(leading: Icon(Icons.person), title: Text('Account')),
            ],
          ),
        ),
      ),
    );
  }
}