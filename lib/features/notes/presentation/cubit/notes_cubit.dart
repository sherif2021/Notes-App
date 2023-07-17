import 'package:bloc/bloc.dart';
import 'package:clean_arch_example/config/di.dart';
import 'package:clean_arch_example/core/error/get_failure_message.dart';
import 'package:clean_arch_example/core/usecases/usecase.dart';
import 'package:clean_arch_example/features/notes/domain/entities/note.dart';
import 'package:clean_arch_example/features/notes/domain/usecases/add_note.dart';
import 'package:clean_arch_example/features/notes/domain/usecases/delete_note.dart';
import 'package:clean_arch_example/features/notes/domain/usecases/get_notes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final addNoteFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final _getNotes = getIt<GetNotes>();

  final _addNote = getIt.get<AddNote>();

  final _deleteNote = getIt.get<DeleteNote>();

  NotesCubit() : super(NotesInit()) {
    getNotes();
  }

  Future<void> getNotes() async {
    if (state is NotesLoading) return;
    if (state is NotesInit) emit(NotesLoading());

    (await _getNotes(
      NoParams(),
    ))
        .fold((l) => emit(NotesError(getFailureMessage(l))),
            (r) => emit(NotesData(r)));
  }

  Future<void> addNote() async {
    (await _addNote(AddNoteParams(
      titleController.text,
      contentController.text,
    )))
        .fold(
      (l) => emit(NotesAddFailed(getFailureMessage(l))),
      (r) => emit(NotesAddSuccessfully()),
    );
    titleController.clear();
    contentController.clear();
    getNotes();
  }

  Future<void> deleteNote(Note note) async {
    (await _deleteNote(note)).fold(
      (l) => emit(NotesDeleteFailed(getFailureMessage(l))),
      (r) => emit(NotesDeletedSuccessfully()),
    );
    getNotes();
  }

  @override
  Future<void> close() {
    titleController.dispose();
    contentController.dispose();
    return super.close();
  }
}
