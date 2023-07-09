import 'package:clean_arch_example/core/error/failure.dart';
import 'package:clean_arch_example/core/usecases/future_usecase.dart';
import 'package:clean_arch_example/features/notes/domain/entities/note.dart';
import 'package:clean_arch_example/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteNote extends FutureUseCase<void, Note> {
  final NotesRepository _notesRepository;

  DeleteNote(this._notesRepository);

  @override
  Future<Either<Failure, void>> call(Note params) {
    return _notesRepository.deleteNote(params);
  }
}
