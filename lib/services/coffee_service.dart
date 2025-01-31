class CoffeeService {
  int _coffeeCount = 0;
  int _dailyLimit = 3;

  Future<int> getCoffeeCount() async {
    return _coffeeCount;
  }

  Future<void> setCoffeeCount(int count) async {
    _coffeeCount = count;
  }

  Future<void> resetCounter() async {
    _coffeeCount = 0;
  }

  Future<int> getDailyLimit() async {
    return _dailyLimit;
  }

  Future<void> setDailyLimit(int limit) async {
    _dailyLimit = limit;
  }
}