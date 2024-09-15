

import '../Model/note_models/note_model.dart';
import '../cores/services/crud_operetion.dart';

class FetchData {
  final ApiServices notes = ApiServices();

  Future<List<Note>> getNote() async {
    try {
      final response = await notes.getApi();
      print('Response from API: $response');

      // Assuming response is already a list of Note objects
      List<Note> noteList = List<Note>.from(response);

      return noteList;
    } catch (e) {
      throw Exception('Failed to load notes: $e');
    }
  }
}
