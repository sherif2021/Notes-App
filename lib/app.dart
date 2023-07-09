import 'package:clean_arch_example/config/utils/app_strings.dart';
import 'package:clean_arch_example/config/utils/app_theme.dart';
import 'package:clean_arch_example/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:clean_arch_example/features/notes/presentation/screens/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<NotesCubit>(
          create: (context) => NotesCubit(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: appTheme(),
        home: const NotesScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
