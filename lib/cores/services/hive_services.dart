import 'package:notes/app_imports.dart';

//2nd way two doing work without using abstract class

class HiveService {
  final String boxName = 'tasksBox';

  Future<Box<Note>> openBox() async {
    return await Hive.openBox<Note>(boxName);
  }

  Future<void> addTask(Note note) async {
    var box = await openBox();
    await box.add(note);
  }

  Future<void> deleteTask(int index) async {
    var box = await openBox();
    await box.deleteAt(index);
  }

  Future<void> updateTask(int index, Note note) async {
    var box = await openBox();
    await box.putAt(index, note);
  }

  Future<List<Note>> getAllTasks() async {
    var box = await openBox();
    return box.values.toList();
  }
}
