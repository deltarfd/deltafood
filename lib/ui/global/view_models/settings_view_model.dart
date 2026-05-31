import 'package:flutter/foundation.dart';

class SettingsViewModel extends ChangeNotifier {
  bool _isGrid = false;
  bool get isGrid => _isGrid;

  void toggleGridLayout() {
    _isGrid = !_isGrid;
    notifyListeners();
  }
}
