import 'package:floor/floor.dart';

@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? title;
  String? description;

  Note({this.id,  this.title,  this.description});

  @override
  String toString() {
    return 'Note{id: $id, title: $title, description: $description}';
  }
}
