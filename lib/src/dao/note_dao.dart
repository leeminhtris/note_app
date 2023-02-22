import 'package:floor/floor.dart';
import '../model/note.dart';

@dao
abstract class NoteDao {
  //lấy danh sách ghi chú
  @Query("SELECT * FROM Note")
  Future<List<Note>> getAllNotes();

  //tìm ghi chú theo id
  @Query("SELECT * FROM note WHERE id = :id")
  Future<Note?> findById(int id);

  //thêm ghi chú
  @insert
  Future<int> addNote(Note note);

  //sửa
  @update
  Future<int> updateNote(Note note);

  //xoá
  @delete
  Future<void> deleteNote(Note note);

  //tìm kiếm theo tiêu đề
  @Query("SELECT * FROM Note WHERE title LIKE :title")
  Future<List<Note>> search(String title);
}
