import 'package:clean_arch_example/core/extensions/localization.dart';
import 'package:clean_arch_example/core/helpes/snackbar_messages.dart';
import 'package:clean_arch_example/core/widgets/center_error_widget.dart';
import 'package:clean_arch_example/core/widgets/center_loading_widget.dart';
import 'package:clean_arch_example/features/notes/domain/entities/note.dart';
import 'package:clean_arch_example/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:clean_arch_example/features/notes/presentation/widgets/note_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state is NotesAddSuccessfully) {
          showSuccessMessages(context, tr(context).note_added_successfully);
        } else if (state is NotesAddFailed) {
          showFailedMessages(
              context, '${tr(context).failed_to_add_note} ${state.error}');
        } else if (state is NotesDeletedSuccessfully) {
          showSuccessMessages(context, tr(context).note_added_successfully);
        } else if (state is NotesDeleteFailed) {
          showFailedMessages(
              context, '${tr(context).failed_to_delete_note} ${state.error}');
        }
      },
      buildWhen: (previous, current) =>
          current is! NotesAddSuccessfully &&
          current is! NotesAddFailed &&
          current is! NotesDeletedSuccessfully &&
          current is! NotesDeleteFailed,
      builder: (context, state) {
        return _buildBody(context, context.read<NotesCubit>(), state);
      },
    );
  }

  Widget _buildBody(BuildContext context, NotesCubit cubit, NotesState state) {
    return Scaffold(
      appBar: AppBar(),
      body: state is NotesLoading
          ? const CenterLoadingWidget()
          : state is NotesData
              ? RefreshIndicator(
                  onRefresh: cubit.getNotes,
                  child: ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (_, index) {
                      final note = state.notes[index];
                      return NoteWidget(
                        note: note,
                        onDeletePressed: () =>
                            _showDeleteDialog(context, cubit, note),
                      );
                    },
                  ),
                )
              : state is NotesError
                  ? CenterErrorWidget(
                      error: state.error,
                      onReloadTapped: cubit.getNotes,
                    )
                  : const SizedBox(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddNoteDialog(context, cubit),
        label: Text(tr(context).add_note),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context, NotesCubit cubit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(tr(context).add_note),
        content: Form(
          key: cubit.addNoteFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: cubit.titleController,
                decoration: InputDecoration(
                  labelText: tr(context).title,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return tr(context).title_is_required;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: cubit.contentController,
                decoration: InputDecoration(
                  labelText: tr(context).content,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return tr(context).content_is_required;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          MaterialButton(
            onPressed: () {
              if (cubit.addNoteFormKey.currentState!.validate()) {
                Navigator.of(context).pop();
                context.read<NotesCubit>().addNote();
              }
            },
            textColor: Colors.green,
            child: Text(tr(context).add),
          ),
          MaterialButton(
            onPressed: Navigator.of(context).pop,
            textColor: Colors.red,
            child: Text(tr(context).close),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, NotesCubit cubit, Note note) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(tr(context).delete_note),
        content: Text(tr(context).delete_note_message),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<NotesCubit>().deleteNote(note);
            },
            textColor: Colors.red,
            child: Text(tr(context).delete),
          ),
          MaterialButton(
            onPressed: Navigator.of(context).pop,
            textColor: Colors.green,
            child: Text(tr(context).cancel),
          ),
        ],
      ),
    );
  }
}
