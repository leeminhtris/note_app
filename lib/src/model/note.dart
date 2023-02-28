import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@entity
@JsonSerializable()
class Note {
  @PrimaryKey(autoGenerate: true)
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'description')
  String? description;

  Note({this.id,  this.title,  this.description});

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  @override
  String toString() {
    return 'Note{id: $id, title: $title, description: $description}';
  }


}
