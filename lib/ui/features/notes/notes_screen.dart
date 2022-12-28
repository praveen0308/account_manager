import 'package:account_manager/models/note_model.dart';
import 'package:account_manager/ui/features/notes/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/app_colors.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
      ),
      body: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {},
        builder: (context, state) {

          if (state is ReceivedNotes) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return NoteView(
                    note: state.notes[index],
                    onClick: () {
                      Navigator.pushNamed(context, "/addNewNote",
                          arguments: state.notes[index]).then((value) => BlocProvider.of<NotesCubit>(context).fetchNotes());
                    }, onDelete: () {
                  BlocProvider.of<NotesCubit>(context).deleteNote(state.notes[index].noteId!);
                },);
              },
              itemCount: state.notes.length,
            );
          }
          if (state is NoNotesFound) {
            return Center(
              child: Column(
                children: const [
                  Icon(Icons.add_box_outlined),
                  Text("No notes found!!")
                ],
              ),
            );
          }
          if (state is Error) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.error),
                  Text(state.msg)
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addNewNote").then((value) => BlocProvider.of<NotesCubit>(context).fetchNotes());
        },
        backgroundColor: AppColors.primaryDarkest,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    ));
  }

  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchNotes();
    super.initState();
  }
}

class NoteView extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onClick;
  final VoidCallback onDelete;

  const NoteView({Key? key, required this.note, required this.onClick, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        note.title ?? "No Title",
                        style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 17),
                      ),

                    ],
                  ),
                  Text(note.description ?? "N.A."),
                  Text(note.getFDate())
                ],
              ),
            ),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
