
import '../db/db_helper.dart';
import '../model/note.dart';

class NoteManager {

  final DBHelper dbHelper = DBHelper();

  Future<List<Note>> getAllNotes() async {
    final noteDao = await dbHelper.getNoteDao();
    return noteDao.getAllNotes();
  }

  Future<int> updateNote(Note note) async{
    final noteDao = await dbHelper.getNoteDao();
    return noteDao.updateNote(note);
  }

  Future<int> addNote(Note note) async {
    final noteDao = await dbHelper.getNoteDao();
    return noteDao.addNote(note);
  }

  Future<void> deleteNote(Note note) async {
    final noteDao = await dbHelper.getNoteDao();
    return noteDao.deleteNote(note);
  }

  Future<List<Note>> findByTitle(String title) async {
    final noteDao = await dbHelper.getNoteDao();
    return noteDao.findByTitle(title);
  }

}