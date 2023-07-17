import 'package:clean_arch_example/config/di.dart';
import 'package:clean_arch_example/config/utils/app_strings.dart';
import 'package:clean_arch_example/config/utils/app_theme.dart';
import 'package:clean_arch_example/features/auth/presentation/cubit/language_cubit.dart';
import 'package:clean_arch_example/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:clean_arch_example/features/notes/presentation/screens/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/extensions/localization.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<LanguageCubit>(
          create: (context) => getIt.get<LanguageCubit>(),
        ),
        RepositoryProvider<NotesCubit>(
          create: (context) => getIt.get<NotesCubit>(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) => MaterialApp(
          title: AppStrings.appName,
          theme: appTheme(),
          home: const NotesScreen(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state,
        ),
      ),
    );
  }
}
