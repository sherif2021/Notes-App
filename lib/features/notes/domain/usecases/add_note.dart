import 'package:clean_arch_example/core/error/failure.dart';
import 'package:clean_arch_example/core/usecases/future_usecase.dart';
import 'package:clean_arch_example/features/notes/domain/entities/note.dart';
import 'package:clean_arch_example/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

class AddNote extends FutureUseCase<void, AddNoteParams> {
  final NotesRepository _notesRepository;

  AddNote(this._notesRepository);

  @override
  Future<Either<Failure, void>> call(AddNoteParams params) {
    return _notesRepository.addNote(Note(
      title: params.title,
      content: params.text,
      createdAt: DateTime.now(),
    ));
  }
}

class AddNoteParams {
  final String title;
  final String text;

  AddNoteParams(this.title, this.text);
}
