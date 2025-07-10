import 'package:flutter/material.dart';

 

void main() => runApp(MyApp());

 

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      home: MyGridScreen(),

    );

  }

}

 

class MyGridScreen extends StatefulWidget {

  MyGridScreen({Key? key}) : super(key: key);

 

  @override

  _MyGridScreenState createState() => _MyGridScreenState();

}

 

class _MyGridScreenState extends State<MyGridScreen> {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text("Welcome to Travels"),

        backgroundColor: Color.fromARGB(255, 12, 67, 245),

      ),

      body: Center(

        child: GridView.extent(

          primary: false,

          padding: const EdgeInsets.all(16),

          crossAxisSpacing: 10,

          mainAxisSpacing: 10,

          maxCrossAxisExtent: 200.0,

          children: <Widget>[

            _buildDestinationButton(

              context,

              'Destination: USA',

              Colors.purple,

              USA(),

            ),

            _buildDestinationButton(

              context,

              'Destination: UK',

              Colors.teal,

              UK(),

            ),

            _buildDestinationButton(

              context,

              'Destination: France',

              Colors.green,

              France(),

            ),

            _buildDestinationButton(

              context,

              'Destination: Japan',

              Colors.pink,

              Japan(),

            ),

          ],

        ),

      ),

    );

  }

 

  Widget _buildDestinationButton(

    BuildContext context,

    String label,

    Color color,

    Widget destination,

  ) {

    return Container(

      padding: const EdgeInsets.all(8),

      child: ElevatedButton(

        child: Text(label),

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (context) => destination,

            ),

          );

        },

      ),

      color: color,

    );

  }

}

 

class Japan extends StatelessWidget {

  const Japan({Key? key}) : super(key: key);

 

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Japan Travels"),

        backgroundColor: Color.fromARGB(255, 245, 12, 206),

      ),

      body: Center(

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            Center(

              child: const Text('Japan ticket cost: Rs.10000'),

            ),

            Center(

              child: ElevatedButton(

                onPressed: () {

                  _showAlert(context, 'Tickets Booked!');

                },

                child: const Text('Book Ticket'),

              ),

            ),

            Center(

              child: ElevatedButton(

                onPressed: () {

                  _showAlert(context, 'Tickets Not Booked!');

                },

                child: const Text('Go Home'),

              ),

            ),

          ],

        ),

      ),

    );

  }

}

 

class USA extends StatelessWidget {

  const USA({Key? key}) : super(key: key);

 

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("USA Travels"),

        backgroundColor: Color.fromARGB(255, 181, 59, 238),

      ),

      body: Center(

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            Center(

              child: const Text('USA ticket cost: Rs.30000'),

            ),

            Center(

              child: ElevatedButton(

                onPressed: () {

                  _showAlert(context, 'Tickets Booked!');

                },

                child: const Text('Book Ticket'),

              ),

            ),

            Center(

              child: ElevatedButton(

                onPressed: () {

                  _showAlert(context, 'Tickets Not Booked!');

                },

                child: const Text('Go Home'),

              ),

            ),

          ],

        ),

      ),

    );

  }

}

 

class UK extends StatelessWidget {

  const UK({Key? key}) : super(key: key);

 

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("UK Travels"),

        backgroundColor: Color.fromARGB(255, 26, 211, 202),

      ),

      body: Center(

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            Center(

              child: const Text('UK ticket cost: Rs.25000'),

            ),

            Center(

              child: ElevatedButton(

                onPressed: () {

                  _showAlert(context, 'Tickets Booked!');

                },

                child: const Text('Book Ticket'),

              ),

            ),

            Center(

              child: ElevatedButton(

                onPressed: () {

                  _showAlert(context, 'Tickets Not Booked!');

                },

                child: const Text('Go Home'),

              ),

            ),

          ],

        ),

      ),

    );

  }

}

 

class France extends StatelessWidget {

  const France({Key? key}) : super(key: key);

 

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("France Travels"),

        backgroundColor: Color.fromARGB(255, 86, 59, 238),

      ),

      body: Center(

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            Center(

              child: const Text('France ticket cost: Rs.20000'),

            ),

            Center(

              child: ElevatedButton(

                onPressed: () {

                  _showAlert(context, 'Tickets Booked!');

                },

                child: const Text('Book Ticket'),

              ),

            ),

            Center(

              child: ElevatedButton(

                onPressed: () {

                  _showAlert(context, 'Tickets Not Booked!');

                },

                child: const Text('Go Home'),

              ),

            ),

          ],

        ),

      ),

    );

  }

}

 

void _showAlert(BuildContext context, String message) {

  showDialog(

    context: context,

    builder: (BuildContext context) {

      return AlertDialog(

        title: Text('Alert'),

        content: Text(message),

        actions: <Widget>[

          TextButton(

            onPressed: () {

              Navigator.of(context).pop();

              Navigator.of(context).pop(); // Close both dialogs and go back

            },

            child: Text('OK'),

          ),

        ],

      );

    },

  );

}

 