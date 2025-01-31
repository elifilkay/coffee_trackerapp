import 'package:flutter/material.dart';
import 'coffee_counter.dart';
import 'tips_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<CoffeeCounterState> _coffeeCounterKey = GlobalKey<CoffeeCounterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COFFEE TRACKER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.brown[200], // Light coffee-toned background
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb, size: 30), // Larger and bolder icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TipsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, size: 30), // Larger and bolder icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen(onLimitUpdated: () {
                  _coffeeCounterKey.currentState?.loadDailyLimit(); // CoffeeCounter'ın sınırı güncellemesini sağla
                })),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/coffee.jpeg',
              fit: BoxFit.fill, // Adjust the image size here
            ),
          ),
          Center(
            child: SizedBox(
              width: 400,
              height: 300,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.brown[100]?.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: CoffeeCounter(key: _coffeeCounterKey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}