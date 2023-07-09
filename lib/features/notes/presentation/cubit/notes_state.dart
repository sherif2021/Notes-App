part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInit extends NotesState {}

class NotesLoading extends NotesState {}

class NotesData extends NotesState {
  final List<Note> notes;

  const NotesData(this.notes);
}

class NotesError extends NotesState {
  final String error;

  const NotesError(this.error);
}

class NotesAddSuccessfully extends NotesState {}

class NotesAddFailed extends NotesState {
  final String error;

  const NotesAddFailed(this.error);
}

class NotesDeletedSuccessfully extends NotesState {}

class NotesDeleteFailed extends NotesState {
  final String error;

  const NotesDeleteFailed(this.error);
}
