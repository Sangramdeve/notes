

import '../../app_imports.dart';

class ApiServices implements BaseApiServices {
  @override
  Future getApi() async {
    try {
      final box = await Hive.openBox('notes');
      return box.values;
    } catch (e) {
      print('getApi: $e');
    }
  }

  @override
  Future putApi(url, data) async {
    try {
      final box = await Hive.openBox('notes');
      box.add(data);
      print('putApi');
    } catch (e) {
      print('putApi: $e');
    }
  }

  @override
  Future patchApi(key, data) async {
    try {
      final box = await Hive.openBox('notes');
      await box.put(key, data);
    } catch (e) {
      print('patchApi: $e');
    }
  }

  @override
  Future deleteApi(markedItemList) async {
    try {
      final box = await Hive.openBox('notes');
      for (int index in markedItemList) {
        await box.deleteAt(index);
      }
      print('Deleted items at indices: $markedItemList');
    } catch (e) {
      print('deleteApi: $e');
    }
  }
}
