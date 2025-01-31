import 'package:flutter/material.dart';
import '../services/coffee_service.dart';
import '../services/notification_service.dart';

class CoffeeCounter extends StatefulWidget {
  CoffeeCounter({Key? key}) : super(key: key);

  @override
  CoffeeCounterState createState() => CoffeeCounterState();
}

class CoffeeCounterState extends State<CoffeeCounter> {
  final CoffeeService _coffeeService = CoffeeService();
  final NotificationService _notificationService = NotificationService();
  int _coffeeCount = 0;
  int _dailyLimit = 0;
  bool _limitExceeded = false;

  @override
  void initState() {
    super.initState();
    _loadCoffeeData();
  }

  void _loadCoffeeData() async {
    _coffeeCount = await _coffeeService.getCoffeeCount();
    _dailyLimit = await _coffeeService.getDailyLimit();
    setState(() {});
    _notificationService.init(); // Initialize notification service
  }

  void loadDailyLimit() async {
    int newLimit = await _coffeeService.getDailyLimit();
    setState(() {
      _dailyLimit = newLimit; // Günlük sınırı güncelle
    });
  }

  void _incrementCoffee() async {
    setState(() {
      _coffeeCount++;
    });

    await _coffeeService.setCoffeeCount(_coffeeCount);

    if (_coffeeCount > _dailyLimit) {
      _limitExceeded = true;
      _showLimitAlert();
      _notificationService.showNotification(
        'Limit Aşıldı!',
        'Bugün $_coffeeCount kahve içtiniz.',
      );
    }
  }

  void _resetCounter() async {
    setState(() {
      _coffeeCount = 0;
      _limitExceeded = false;
    });
    await _coffeeService.resetCounter();
  }

  void _showLimitAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dikkat!'),
          content: Text('Günlük kahve sınırını aştınız.'),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Bugün içilen kahve sayısı:', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Roboto Mono")),
        Text('$_coffeeCount', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _incrementCoffee,
          child: Text('Kahve İçtim', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.brown)),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: _resetCounter,
          child: Text('Sayaç Sıfırla', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.brown)),
        ),
      ],
    );
  }
}