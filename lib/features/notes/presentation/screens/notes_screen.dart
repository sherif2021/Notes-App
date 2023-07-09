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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Note added successfully'),
            ),
          );
        } else if (state is NotesAddFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add note ${state.error}'),
            ),
          );
        } else if (state is NotesDeletedSuccessfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Note deleted successfully'),
            ),
          );
        } else if (state is NotesDeleteFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete note ${state.error}'),
            ),
          );
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
        label: const Text(
          'Add Note',
        ),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context, NotesCubit cubit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: Form(
          key: cubit.addNoteFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: cubit.titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Title is required';
                  return null;
                },
              ),
              TextFormField(
                controller: cubit.contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Content is required';
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
            child: const Text('Add'),
          ),
          MaterialButton(
            onPressed: Navigator.of(context).pop,
            textColor: Colors.red,
            child: const Text('Close'),
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
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this Note?'),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<NotesCubit>().deleteNote(note);
            },
            textColor: Colors.red,
            child: const Text('Delete'),
          ),
          MaterialButton(
            onPressed: Navigator.of(context).pop,
            textColor: Colors.green,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
