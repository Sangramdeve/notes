import 'package:flutter/widgets.dart';

class NoteProvider with ChangeNotifier {
  int _selectedIndex = -1;
  List<int> _markedItemList = [];
  bool _openMark = false;

  int get selectedIndex => _selectedIndex;
  List<int> get markedItemList => _markedItemList;
  bool get openMark => _openMark;

  void oneOption(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void openItemMark() {
    _openMark = !openMark;
    notifyListeners();
  }

  void markItem(int index) {
    if(_markedItemList.contains(index)){
      _markedItemList.remove(index);
    }else{
      _markedItemList.add(index);
    }
    notifyListeners();
  }

  // To clear the marking
  void unmarkItem(int index) {
    _markedItemList.clear();
    notifyListeners();
  }
}
