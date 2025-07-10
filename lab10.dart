import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      String jsonString = await rootBundle.loadString('assets/user.json');
      List<dynamic> jsonData = json.decode(jsonString);
      final enteredUsername = usernameController.text.trim();
      final enteredPassword = passwordController.text.trim();

      for (var user in jsonData) {
        if (user['name'] == enteredUsername &&
            user['password'] == enteredPassword) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfilePage(
                username: enteredUsername,
                image: user['image'],
              ),
            ),
          );
          return;
        }
      }
      // Show an alert for incorrect credentials
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('Please enter valid username and password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Show an alert for any errors during file reading or JSON parsing
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to read user data: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/w.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(16.0),
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    _login(context);
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final String username;
  final String image;

  const UserProfilePage({required this.username, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/w.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(image),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome, $username!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainFeedPage(
                        username: username,
                      ),
                    ),
                  );
                },
                child: Text('Main Feed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Post {
  final String name;
  final String heading;
  final String content;
  final String image;
  final String comments;

  Post({
    required this.name,
    required this.heading,
    required this.content,
    required this.image,
    required this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'heading': heading,
      'content': content,
      'image': image,
      'comments': comments,
    };
  }
}

class CreatePostScreen extends StatefulWidget {
  final String username;
  final Function(Post) onPostCreated;

  const CreatePostScreen({required this.username, required this.onPostCreated});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController headingController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String? imagePath; // This will hold the path to the selected image

  Future<void> _pickImage() async {
    TextEditingController imageController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Set Image Path"),
          content: TextFormField(
            controller: imageController,
            decoration: InputDecoration(
              labelText: 'Image Path',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  imagePath = imageController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Set'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: headingController,
              decoration: InputDecoration(
                labelText: 'Heading',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a heading';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final heading = headingController.text;
                final content = contentController.text;

                if (heading.isNotEmpty) {
                  final Post newPost = Post(
                    heading: heading,
                    content: content,
                    image: imagePath ??
                        '', // Assign imagePath if not null, else assign an empty string
                    name: widget.username, comments: '',
                  );
                  widget.onPostCreated(newPost);
                  Navigator.of(context).pop(); // Return to previous screen
                } else {
                  showDialog(
                    // Show an alert if the heading is empty
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Empty Heading'),
                        content: Text('Please enter a heading for your post.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainFeedPage extends StatefulWidget {
  final String username;

  const MainFeedPage({required this.username});

  @override
  _MainFeedPageState createState() => _MainFeedPageState();
}

class _MainFeedPageState extends State<MainFeedPage> {
  List<Map<String, String>> posts = [
    {
      "name": "Sam23",
      "heading": "Happy birthday Sam!",
      "content": "Live a happy long life!",
      "image": "assets/cake.jpg",
      "comments": ""
    },
    {
      "name": "Ara",
      "heading": "My new pet!",
      "content": "Meet Ash!",
      "image": "assets/cat.jpeg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    String currentUser = widget.username;

    Future<void> _showCommentDialog(BuildContext context, int index) async {
      String comment = '';

      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add a Comment'),
            content: TextField(
              onChanged: (value) {
                comment = value;
              },
              decoration: InputDecoration(
                labelText: 'Enter your comment',
                border: OutlineInputBorder(),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Update the comments list for the corresponding post
                    posts[index]["comments"] = comment;
                  });

                  Navigator.of(context).pop();
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Main Feed'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(posts[index]['heading']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(posts[index]['content']!),
                      SizedBox(height: 8),
                      Text('By: ${posts[index]['name']}'),
                      if (posts[index]['image'] != null &&
                          posts[index]['image']!.isNotEmpty)
                        Image.asset(
                          posts[index]['image']!,
                        ),
                      if (posts[index]['comments'] != null &&
                          posts[index]['comments']!.isNotEmpty)
                        Text(
                          'Comments: ${posts[index]['comments']}', // Show comments
                          style: TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final newPost = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPostScreen(
                              username: widget.username,
                              initialHeading: posts[index]['heading']!,
                              initialContent: posts[index]['content']!,
                              initialImagePath: posts[index]['image'],
                              updatePost: (String newHeading, String newContent,
                                  String? newImagePath) {
                                setState(() {
                                  // Update the post data in the list
                                  posts[index]['heading'] = newHeading;
                                  posts[index]['content'] = newContent;
                                  posts[index]['image'] = newImagePath!;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Remove the post from the list
                          posts.removeAt(index);
                        });
                      },
                      child: Text('Delete'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showCommentDialog(context,
                            index); // Pass the index of the current post
                      },
                      child: Text('Comment'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPost = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostScreen(
                username: currentUser,
                onPostCreated: (post) {
                  setState(() {
                    // Convert the Post object to a Map and add it to posts
                    posts.add({
                      'name': post.name,
                      'heading': post.heading,
                      'content': post.content,
                      'image': post.image ??
                          '', // Provide a default value if imagePath is null
                    });
                  });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EditPostScreen extends StatefulWidget {
  final String username;
  final String initialHeading;
  final String initialContent;
  final String? initialImagePath;

  final void Function(
      String newHeading, String newContent, String? newImagePath) updatePost;

  EditPostScreen({
    Key? key,
    required this.username,
    required this.initialHeading,
    required this.initialContent,
    this.initialImagePath,
    required this.updatePost,
  }) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late TextEditingController headingController;
  late TextEditingController contentController;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    headingController = TextEditingController(text: widget.initialHeading);
    contentController = TextEditingController(text: widget.initialContent);
    imagePath = widget.initialImagePath;
  }

  Future<void> _pickImage() async {
    TextEditingController imageController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Set Image Path"),
          content: TextFormField(
            controller: imageController,
            decoration: InputDecoration(
              labelText: 'Image Path',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  imagePath = imageController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Set'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: headingController,
              decoration: InputDecoration(
                labelText: 'Heading',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final heading = headingController.text;
                final content = contentController.text;

                // Call the updatePost callback with the updated data
                widget.updatePost(heading, content, imagePath);

                Navigator.of(context)
                    .pop(); // Return to the previous screen after editing
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
