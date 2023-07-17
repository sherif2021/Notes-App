import 'package:clean_arch_example/core/error/failure.dart';
import 'package:clean_arch_example/features/notes/domain/entities/note.dart';
import 'package:dartz/dartz.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<Note>>> getNotes();

  Future<Either<Failure, void>> addNote(Note note);

  Future<Either<Failure, void>> deleteNote(Note note);
}
