import '../common/common.dart';
import '../dao/note_dao.dart';
import 'note_database.dart';

class DBHelper {
  Future<NoteDatabase> getDatabase() async {
    return await $FloorNoteDatabase.databaseBuilder(DB_NAME).build();
  }

  Future<NoteDao> getNoteDao() async {
    return await getDatabase().then((value) => value.noteDao);
  }
}