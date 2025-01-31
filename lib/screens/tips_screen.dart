import 'package:flutter/material.dart';

class TipsScreen extends StatefulWidget {
  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  final List<String> tips = [
    '1. Drink coffee in moderation.',
    '2. Avoid drinking coffee late in the day.',
    '3. Choose quality coffee beans.',
    '4. Stay hydrated by drinking water alongside coffee.',
    '5. Experiment with different brewing methods.',
    '6. Store coffee beans in a cool, dark place.',
    '7. Grind coffee beans just before brewing.',
    '8. Use filtered water for brewing coffee.',
  ];

  final Set<String> favoriteTips = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Tips', style: TextStyle(color: Colors.deepOrange)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: ListView(
            shrinkWrap: true,
            children: tips.map((tip) => _buildTipCard(tip)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(String tip) {
    final isFavorite = favoriteTips.contains(tip);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                tip,
                style: TextStyle(fontSize: 20),
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    favoriteTips.remove(tip);
                  } else {
                    favoriteTips.add(tip);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}