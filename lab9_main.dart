import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to Testing"),
          backgroundColor: Color.fromARGB(255, 226, 7, 255),
        ),
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/w.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: CustomButton(initialText: 'Tap me'),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SignButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String initialText;

  CustomButton({required this.initialText});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late String buttonText;
  late Color buttonColor;

  @override
  void initState() {
    super.initState();
    buttonText = widget.initialText;
    buttonColor = Color.fromARGB(255, 226, 7, 255);
  }

  void _handleTap() {
    setState(() {
      if (buttonText == 'Tap me') {
        buttonText = 'Changed on Tap';
        buttonColor = Colors.blue;
      } else {
        buttonText = 'Tap me';
        buttonColor = Color.fromARGB(255, 226, 7, 255);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleTap();
      },
      child: Container(
        color: buttonColor,
        padding: EdgeInsets.all(16.0),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SignButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Sign-In page when the button is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      },
      child: Container(
        color: Color.fromARGB(255, 76, 87, 204),
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-In Page'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/w.jpg'), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 500,
              height: 500,
              padding: EdgeInsets.all(16.0),
              color: Color.fromARGB(255, 239, 191, 243)
                  .withOpacity(0.8), // Background color with opacity
              child: RegistrationForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Text(
                "Sign-in Form",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              key: Key('nameField'),
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name cannot be empty';
                }
                return null;
              },
            ),
            TextFormField(
              key: Key('emailField'),
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email cannot be empty';
                }
                if (!isValidEmail(value)) {
                  return 'Invalid email format';
                }
                return null;
              },
            ),
            TextFormField(
              key: Key('passwordField'),
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password cannot be empty';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form fields are valid, navigate to ItemListPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemListPage(),
                        ),
                      );
                    } else {
                      // Form fields are not valid, display an error message
                      setState(() {
                        _errorText = 'Please fix the errors in the form.';
                      });
                    }
                  },
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
            Text(
              _errorText,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Simple email validation using a regular expression
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
  }
}

class ItemListPage extends StatelessWidget {
  final List<Item> items = [
    Item(name: 'Strawberry Cake', price: 20.0, imageUrl: 'assets/item1.jpg'),
    Item(name: 'Ice Cream Brownie', price: 15.0, imageUrl: 'assets/item2.jpg'),
    Item(name: 'Gulab Jamun', price: 25.0, imageUrl: 'assets/item3.jpg'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to the home page when the home button is tapped
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // List of Items
            for (var item in items)
              Card(
                child: Column(
                  children: [
                    Image.asset(
                      item.imageUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Item {
  final String name;
  final double price;
  final String imageUrl;

  Item({required this.name, required this.price, required this.imageUrl});
}
