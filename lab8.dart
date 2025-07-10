//Edit pubspec.yaml to add http under dependency

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class FoodItem {
  final String name;
  final double price;
  final double rating;
  final String image;

  FoodItem({
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Food Ordering App"),
        ),
        body: FutureBuilder<List<FoodItem>>(
          future: fetchFoodItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Stack(
                children: [
                  Image.asset(
                    'assets/w.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  FoodGrid(foodItems: snapshot.data!),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

Future<List<FoodItem>> fetchFoodItems() async {
  try {
    final response = await http.get(
      Uri.parse(
          'https://raw.githubusercontent.com/SamuelaAbigail/food_menu/main/food.json'),
      headers: {"Accept": "application/json"},
    ).timeout(
        const Duration(seconds: 10)); // Set your desired timeout duration here

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((item) => FoodItem(
                name: item['name'],
                price: item['price'].toDouble(),
                rating: item['rating'].toDouble(),
                image: item['image'],
              ))
          .toList();
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  } on TimeoutException {
    throw Exception('Request timed out. Please check your network connection.');
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

class FoodGrid extends StatelessWidget {
  final List<FoodItem> foodItems;

  const FoodGrid({Key? key, required this.foodItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 15,
        crossAxisCount: 3, // 3 items in each row
      ),
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        final foodItem = foodItems[index];
        return FoodCard(foodItem: foodItem);
      },
    );
  }
}

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodCard({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(
            foodItem.image,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  foodItem.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Price: \$${foodItem.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Rating: ${foodItem.rating.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
