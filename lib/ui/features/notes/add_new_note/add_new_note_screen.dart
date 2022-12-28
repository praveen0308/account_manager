import 'package:account_manager/ui/features/notes/add_new_note/add_new_note_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/note_model.dart';

class AddNewNoteScreen extends StatefulWidget {
  final NoteModel? note;
  const AddNewNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddNewNoteScreen> createState() => _AddNewNoteScreenState();
}

class _AddNewNoteScreenState extends State<AddNewNoteScreen> {
  int noteId = 0;
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    if(widget.note!=null){
      noteId = widget.note!.noteId!;
      _title.text = widget.note!.title??"";
      _description.text = widget.note!.description??"";
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        actions: [
          // TextButton(onPressed: (){}, child: const Text("Save"))
        ],
      ),
      body: BlocListener<AddNewNoteCubit, AddNewNoteState>(
  listener: (context, state) {
    if(state is AddedSuccessfully){
      showToast("Added successfully!!!",ToastType.success);
      Navigator.pop(context,true);

    }
    if(state is Error){
      showToast(state.msg,ToastType.error);


    }

  },
  child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: _title,
                    decoration: const InputDecoration.collapsed(hintText: "Title",),
                    scrollPadding: const EdgeInsets.all(8.0),
                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),

                    keyboardType: TextInputType.multiline,
                    ),
                  const SizedBox(height: 16,),
                  TextField(
                    controller: _description,
                    decoration: const InputDecoration.collapsed(hintText: "Enter your text...",),
                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                    scrollPadding: const EdgeInsets.all(20.0),
                    keyboardType: TextInputType.multiline,
                    maxLines: 10000,
                    autofocus: true,)
                ],
              ),
            ),
            Positioned(left: 0,right: 0,bottom: 0,child: ElevatedButton(onPressed: (){
              if(noteId==0){

                BlocProvider.of<AddNewNoteCubit>(context).addNewNote(NoteModel(
                  title: _title.text,
                  description: _description.text,

                ));
              }else{
                BlocProvider.of<AddNewNoteCubit>(context).updateNote(NoteModel(
                  noteId: noteId,
                  title: _title.text,
                  description: _description.text,
                  addedOn: widget.note!.addedOn

                ));
              }
            }, child: Text("Save")))
          ],
        ),
      ),
),
      resizeToAvoidBottomInset: true,
    );
  }
}
