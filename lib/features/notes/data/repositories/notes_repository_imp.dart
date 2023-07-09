import 'package:clean_arch_example/core/error/exceptions.dart';
import 'package:clean_arch_example/core/error/failure.dart';
import 'package:clean_arch_example/features/notes/data/datasource/notes_local_data_source.dart';
import 'package:clean_arch_example/features/notes/domain/entities/note.dart';
import 'package:clean_arch_example/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

class NotesRepositoryImp implements NotesRepository {
  final NotesLocalDataSource _notesLocalDataSource;

  NotesRepositoryImp(this._notesLocalDataSource);

  @override
  Future<Either<Failure, void>> addNote(Note note) async {
    try {
      return Right(await _notesLocalDataSource.addNote(note.toModel));
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(Note note) async {
    try {
      return Right(await _notesLocalDataSource.deleteNote(note.toModel));
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    }
  }

  @override
  Either<Failure, List<Note>> getNotes()  {
    try {
      final data = _notesLocalDataSource.getNotes();
      return Right(data);
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    }
  }
}
