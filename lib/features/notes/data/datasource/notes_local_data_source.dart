import 'package:clean_arch_example/core/database/app_database.dart';
import 'package:clean_arch_example/features/notes/domain/entities/note.dart';
import 'package:drift/drift.dart';

abstract class NotesLocalDataSource {
  Future<List<Note>> getNotes();

  Future<void> addNote(Note note);

  Future<void> deleteNote(Note note);
}

class NotesLocalDataSourceImp implements NotesLocalDataSource {
  final AppDatabase _storage;

  NotesLocalDataSourceImp(this._storage);

  @override
  Future<void> addNote(Note note) async {
    final companion = note.toCompanion();
    await _storage.noteModel.insertOne(companion);
  }

  @override
  Future<void> deleteNote(Note note) async {
    final companion = note.toCompanion();
    _storage.noteModel.deleteOne(companion);
  }

  @override
  Future<List<Note>> getNotes() async {
    final result = await _storage.noteModel.all().get();

    return result.map(Note.fromData).toList();
  }
}
