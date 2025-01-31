import 'package:flutter/material.dart';
import '../services/coffee_service.dart';

class SettingsScreen extends StatefulWidget {
  final Function onLimitUpdated;

  SettingsScreen({required this.onLimitUpdated});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final CoffeeService _coffeeService = CoffeeService();
  final TextEditingController _limitController = TextEditingController();
  int _dailyLimit = 0;

  @override
  void initState() {
    super.initState();
    _loadDailyLimit();
  }

  void _loadDailyLimit() async {
    _dailyLimit = await _coffeeService.getDailyLimit();
    _limitController.text = _dailyLimit.toString();
    setState(() {});
  }

  void _updateDailyLimit() async {
    final int newLimit = int.tryParse(_limitController.text) ?? _dailyLimit;
    if (newLimit > 0) {
      await _coffeeService.setDailyLimit(newLimit);
      setState(() {
        _dailyLimit = newLimit;
      });
      widget.onLimitUpdated(); // CoffeeCounter'a sınırın güncellendiğini bildir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sınır başarıyla güncellendi!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Geçersiz sınır değeri.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ayarlar')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _limitController,
                decoration: InputDecoration(
                  labelText: 'Günlük Kahve Sınırı',
                  labelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateDailyLimit,
                child: Text('Sınırı Güncelle', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}