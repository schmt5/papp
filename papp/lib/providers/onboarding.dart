import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding with ChangeNotifier {
  bool _isOnboarded;

  bool get isOnboarded {
    var val = _isOnboarded;
    return val;
  }

  // shared Preferences
  Future<void> fetchAndSetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    _isOnboarded = prefs.getBool('isOnboarded') ?? false;
  }

  setIsOnboarded(bool status) {
    _isOnboarded = status;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isOnboarded', status);
    });
  }
}
