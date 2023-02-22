import 'dart:async';
import 'package:floor/floor.dart';
import 'package:note/src/dao/note_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../common/common.dart';
import '../model/note.dart';

part 'note_database.g.dart';

@Database(version: DB_VERSION, entities: [Note])
abstract class NoteDatabase extends FloorDatabase {
  NoteDao get noteDao;
}
