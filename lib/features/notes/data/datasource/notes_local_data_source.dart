import 'dart:convert';

import 'package:clean_arch_example/core/constants/local_storage_keys.dart';
import 'package:clean_arch_example/features/notes/data/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NotesLocalDataSource {
  List<NoteModel> getNotes();

  Future<void> addNote(NoteModel note);

  Future<void> deleteNote(NoteModel note);
}

class NotesLocalDataSourceImp implements NotesLocalDataSource {
  final SharedPreferences _storage;

  NotesLocalDataSourceImp(this._storage);

  @override
  Future<void> addNote(NoteModel note) async {
    final notes = getNotes();
    notes.add(note);
    await _saveNotes(notes);
  }

  @override
  Future<void> deleteNote(NoteModel note) async {
    final notes = getNotes();
    notes.remove(note);
    await _saveNotes(notes);
  }

  @override
  List<NoteModel> getNotes() {
    final data = _storage.getString(LocalStorageKeys.notesKey);
    if (data == null) return [];
    return (jsonDecode(data) as List)
        .map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveNotes(List<NoteModel> notes) async {
    await _storage.setString(
      LocalStorageKeys.notesKey,
      jsonEncode(
        notes.map((e) => e.toJson()).toList(),
      ),
    );
  }
}
