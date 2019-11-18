import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Points with ChangeNotifier {
  int _pappTaler;
  int _xp;
  int _level;
  int _daysLeft;
  int _choosenReward;

  // getters
  int get pappTaler {
    var val = _pappTaler;
    return val;
  }

  int get xp {
    var val = _xp;
    return val;
  }

  int get level {
    var val = _level;
    return val;
  }

  int get daysLeft {
    var val = _daysLeft;
    return val;
  }

  int get choosenReward {
    var val = _choosenReward;
    return val;
  }

  Future<void> fetchAndSetPoints() async {
    if (_pappTaler == null ||
        _xp == null ||
        _level == null ||
        _daysLeft == null ||
        _choosenReward == null) {
      final prefs = await SharedPreferences.getInstance();
      _pappTaler = prefs.getInt('pappTaler') ?? 0;
      _xp = prefs.getInt('xp') ?? 0;
      _level = prefs.getInt('level') ?? 0;
      _daysLeft = prefs.getInt('daysLeft') ?? 0;
      _choosenReward = prefs.getInt('choosenReward') ?? 0;
    }
  }

  setPappTaler(int earnedPappTaler) async {
    if (_pappTaler == null) {
      await fetchAndSetPoints();
    }
    // optimistic update
    var previousValue = _pappTaler;
    _pappTaler += earnedPappTaler;
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('pappTaler', _pappTaler);
    }).catchError((err) {
      _pappTaler = previousValue;
      notifyListeners();
    });
  }

  setXp(int earnedXp) async {
    if (_xp == null) {
      await fetchAndSetPoints();
    }
    // optimistic update
    var previousValue = _xp;
    _xp += earnedXp;
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('xp', _xp);
    }).catchError((err) {
      _xp = previousValue;
      notifyListeners();
    });
  }
}
