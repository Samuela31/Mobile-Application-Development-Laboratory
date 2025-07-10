//Edit pubspec.yaml and add photo viewer under dependency

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
          title: const Text("Welcome to ShopEdge"),
        ),
        body: ShopEdge(),
      ),
    );
  }
}

class ShopEdge extends StatelessWidget {
  const ShopEdge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // Set the background image here
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/w.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            ProductCard(
              name: 'Water bottle',
              description: 'Price: Rs.150',
              image: 'assets/bottle1.png',
            ),
            ProductCard(
              name: 'Glitter powder',
              description: 'Price: Rs.320',
              image: 'assets/glitter.png',
            ),
            ProductCard(
              name: 'Keychain',
              description: 'Price: Rs.350',
              image: 'assets/keychain.png',
            ),
          ],
        ));
  }
}

class ProductCard extends StatefulWidget {
  final String name;
  final String description;
  final String image;

  const ProductCard({
    required this.name,
    required this.description,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // Show the pop-up menu when swiped horizontally
        if (details.primaryVelocity! < 0) {
          // Swiped from right to left (Add to Cart)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Added to Cart'),
          ));
        } else if (details.primaryVelocity! > 0) {
          // Swiped from left to right (Save for Later)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Saved for Later'),
          ));
        }
      },
      onTap: toggleExpansion,
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? 400 : 100, // Adjust the desired expanded height
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              // Wrap the Column with a ListView
              shrinkWrap: true,
              children: <Widget>[
                if (isExpanded)
                  Align(
                    alignment: Alignment.centerLeft, // Align image to the left
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      child: PhotoView(
                        backgroundDecoration: BoxDecoration(
                          color: Colors.white, // Customize the background color
                        ),
                        imageProvider: AssetImage(widget.image),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      ),
                    ),
                  ),
                Text(widget.name),
                Text(widget.description),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void _showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position: RelativeRect.fill,
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Add to Cart'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Added to Cart')),
              );
              Navigator.of(context).pop();
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.save),
            title: Text('Save for Later'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Saved for Later')),
              );
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
