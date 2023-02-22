import '../manager/note_manager.dart';
import '../model/note.dart';

class NoteController {
  final NoteManager noteManager = NoteManager();

  Future<List<Note>> getALlNotes() {
    return noteManager.getAllNotes();
  }

  Future<int> addNote(Note note) {
    return noteManager.addNote(note);
  }

  Future<int> updateNote(Note note) {
    return noteManager.updateNote(note);
  }

  Future<void> deleteNote(Note note) {
    return noteManager.deleteNote(note);
  }

  Future<List<Note>> search(String title) {
    return noteManager.search(title);
  }
}
