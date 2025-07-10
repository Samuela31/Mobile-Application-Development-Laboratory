//edit pubspec.yaml also

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
        title: Text("Welcome to Cooking Recipes"),
        backgroundColor: Color.fromARGB(255, 12, 67, 245),
        leading: IconButton(
          icon: Icon(Icons.kebab_dining),
          onPressed: () {
            // Add your icon's action here
          },
        ),
      ),
      body: Container(
        // Set the background image here
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cook.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: GridView.extent(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200.0,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  child: const Text('Fried Rice'),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            // Background Image
                            Image.asset(
                              'assets/friedrice.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            // Content of the BottomSheet
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Text(
                                      'Ingredients: Carrots, Beans, Peas, Rice \n\nPreparation time: 30 minutes\n\nInstructions: Cut carrots, beans and boil along with peas. Then cook with rice and garnish.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                color: Color.fromARGB(255, 181, 59, 238),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  child: const Text('Jalebi'),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            // Background Image
                            Image.asset(
                              'assets/jalebi.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            // Content of the BottomSheet
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Ingredients: Flour, Sugar, Water \n\nPreparation time: 50 minutes\n\nInstructions: Roll dough and fry it till brown. Soak in sugar syrup.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                color: Color.fromARGB(255, 26, 211, 202),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  child: const Text('Chicken Biryani'),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            // Background Image
                            Image.asset(
                              'assets/cbir.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            // Content of the BottomSheet
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Text(
                                      'Ingredients: Chicken, Biryani masala, Biryani rice, Spices \n\nPreparation time: 1 hour\n\nInstructions: Clean chicken pieces and boil. Keep in a pressure cooker along with biryani rice and spices.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                color: Color.fromARGB(255, 86, 59, 238),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  child: const Text('Potato Fries'),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            // Background Image
                            Image.asset(
                              'assets/pfry.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            // Content of the BottomSheet
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Text(
                                      'Ingredients: Potatoes, Oil, Salt, Masala\n\nPreparation time: 20 minutes\n\nInstructions: Cut potatoes into stick shapes and apply masala. Fry in oil till crisp.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                color: Color.fromARGB(255, 245, 12, 206),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

