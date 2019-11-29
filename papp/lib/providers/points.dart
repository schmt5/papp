import 'dart:math' as math;

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

  int get xpForNextLevel {
    const exponent = 1.5;
    const base = 40;
    var lvl = level;
    var nextLevel = (math.pow(lvl, exponent) * base);
    int nextLevelFloor = nextLevel.floor();
    return nextLevelFloor;
  }

  double get percentOfNextLevel {
    if (xp == null || level == null) {
      return 0.2;
    }
    var lowerBound = (math.pow(level - 1, 1.5) * 40);
    var upperBound = xpForNextLevel;
    var deltaBound = upperBound - lowerBound;
    var xpInThatLevel = xp - lowerBound;

    return xpInThatLevel / deltaBound;
  }

  bool _isNextLevel() {
    var treshhold = xpForNextLevel;
    return xp >= treshhold;
  }

  bool gonnaBeNextLevel(int newXp) {
    int totalXp;
    if (xp == null) {
      return false;
    }
    totalXp = newXp + xp;
    return totalXp >= xpForNextLevel;
  }

  // shared Preferences
  Future<void> fetchAndSetPoints() async {
    if (_pappTaler == null ||
        _xp == null ||
        _level == null ||
        _daysLeft == null ||
        _choosenReward == null) {
      final prefs = await SharedPreferences.getInstance();
      _pappTaler = prefs.getInt('pappTaler') ?? 1;
      _xp = prefs.getInt('xp') ?? 1;
      _level = prefs.getInt('level') ?? 1;
      _daysLeft = prefs.getInt('daysLeft') ?? 64;
      _choosenReward = prefs.getInt('choosenReward');
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
    var previousXp = _xp;
    var previousLevel = _level;
    _xp += earnedXp;
    var isNextLevel = _isNextLevel();
    if (isNextLevel) {
      _level++;
    }
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('xp', _xp);
      if (isNextLevel) {
        prefs.setInt('level', _level);
      }
    }).catchError((err) {
      _xp = previousXp;
      _level = previousLevel;
      notifyListeners();
    });
  }

  setChoosenReward(int usersChoice) async {
    if (_choosenReward == null) {
      await fetchAndSetPoints();
    }
    // optimistic update
    var previousChoice = _choosenReward;
    _choosenReward = usersChoice;
    notifyListeners();

    try {
      var prefs = await SharedPreferences.getInstance();
      prefs.setInt('choosenReward', _choosenReward);
    } catch (err) {
      _choosenReward = previousChoice;
      notifyListeners();
    }
  }
}
