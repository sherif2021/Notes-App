import 'package:clean_arch_example/features/notes/data/datasource/notes_local_data_source.dart';
import 'package:clean_arch_example/features/notes/domain/repositories/notes_repository.dart';
import 'package:clean_arch_example/features/notes/domain/usecases/add_note.dart';
import 'package:clean_arch_example/features/notes/domain/usecases/delete_note.dart';
import 'package:clean_arch_example/features/notes/domain/usecases/get_notes.dart';
import 'package:clean_arch_example/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/notes/data/repositories/notes_repository_imp.dart';

GetIt getIt = GetIt.instance;

class DI {
  static final DI _singleton = DI._internal();

  factory DI() => _singleton;

  DI._internal();

  Future<void> init() async {
    // Cubits
    getIt.registerFactory<NotesCubit>(() => NotesCubit());

    // Data Sources
    final sp = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sp);

    // Repositories
    getIt.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImp(
        NotesLocalDataSourceImp(sp),
      ),
    );

    // Use Cases
    getIt.registerLazySingleton(() => GetNotes(getIt.get()));
    getIt.registerLazySingleton(() => AddNote(getIt.get()));
    getIt.registerLazySingleton(() => DeleteNote(getIt.get()));
  }
}
