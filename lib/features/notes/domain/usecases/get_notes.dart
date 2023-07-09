import 'package:clean_arch_example/core/error/failure.dart';
import 'package:clean_arch_example/core/usecases/usecase.dart';
import 'package:clean_arch_example/features/notes/domain/entities/note.dart';
import 'package:clean_arch_example/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

class GetNotes implements UseCase<List<Note>, NoParams> {
  final NotesRepository _notesRepository;

  GetNotes(this._notesRepository);

  @override
  Either<Failure, List<Note>> call(NoParams params) {
    return _notesRepository.getNotes();
  }
}
