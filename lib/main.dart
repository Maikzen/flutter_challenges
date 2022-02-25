import 'package:flutter/material.dart';
import 'package:flutter_challenges/animation_beers/animation_beers_screen.dart';
import 'package:flutter_challenges/daily_ui/daily_ui_screen.dart';
import 'package:flutter_challenges/mountain_view/mountain_view_screen.dart';
import 'package:flutter_challenges/side_menu_animation/side_menu_animation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Challenges Maikzen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Challenges Maikzen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DailyUIScreen()),
                  );
                },
                child: const Text('Daily UI')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnimationBeersScreen()),
                  );
                },
                child: const Text('Beers Animation')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SideMenuAnimationScreen()),
                  );
                },
                child: const Text('Side Menu Animation')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MountainViewScreen()),
                  );
                },
                child: const Text('Mountain view')),
          ],
        ));
  }
}
