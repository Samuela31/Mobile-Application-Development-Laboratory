import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob9/main.dart';

void main() {
  testWidgets('Simulate tap gesture on CustomButton',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CustomButtonTest(),
    ));

    expect(find.text('Tap me'), findsOneWidget);

    await tester.tap(find.byType(CustomButton));
    await tester.pump();

    expect(find.text('Changed on Tap'), findsOneWidget);
  });

  testWidgets('Form Validation Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the Sign In button.
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Verify that the form validation error is shown.
    expect(find.text('Name cannot be empty'), findsOneWidget);
    expect(find.text('Email cannot be empty'), findsOneWidget);
    expect(find.text('Password cannot be empty'), findsOneWidget);

    // Enter valid values in the form.
    await tester.enterText(find.byKey(Key('nameField')), 'John Doe');
    await tester.enterText(
        find.byKey(Key('emailField')), 'john.doe@example.com');
    await tester.enterText(find.byKey(Key('passwordField')), 'password123');

    // Tap the Login button.
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify that the form navigation works.
    expect(find.text('Item List'), findsOneWidget);
  });

  testWidgets('Navigation Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the Sign In button.
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Verify that the Sign In page is displayed.
    expect(find.text('Sign-In Page'), findsOneWidget);

    // Tap the back button to navigate back to the home page.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify that the home page is displayed.
    expect(find.text('Welcome to Testing'), findsOneWidget);
  });

  testWidgets('Scrolling Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the Sign In button.
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Verify that the Sign In page is displayed.
    expect(find.text('Sign-In Page'), findsOneWidget);

    // Scroll down the Sign In page.
    await tester.fling(
        find.byType(SingleChildScrollView), const Offset(0, -200), 3000);
    await tester.pumpAndSettle();

    // Verify that scrolling works.
    expect(find.text('Sign-in Form'), findsOneWidget);
  });
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

class CustomButtonTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomButton(initialText: 'Tap me'),
      ),
    );
  }
}