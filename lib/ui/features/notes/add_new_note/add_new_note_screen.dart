import 'package:account_manager/ui/features/notes/add_new_note/add_new_note_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/note_model.dart';
import '../../../../res/app_colors.dart';
import '../../../../widgets/outlined_text_field.dart';

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
    if (widget.note != null) {
      noteId = widget.note!.noteId!;
      _title.text = widget.note!.title ?? "";
      _description.text = widget.note!.description ?? "";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          BlocProvider.of<AddNewNoteCubit>(context)
              .draftNote(NoteModel(
            title: _title.text,
            description: _description.text,
          ));

          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.note == null ? "New Note" : "Edit Note"),
            actions: [
              TextButton(onPressed: (){
                if (noteId == 0) {
                  BlocProvider.of<AddNewNoteCubit>(context)
                      .addNewNote(NoteModel(
                    title: _title.text,
                    description: _description.text,
                  ));
                } else {
                  BlocProvider.of<AddNewNoteCubit>(context)
                      .updateNote(NoteModel(
                      noteId: noteId,
                      title: _title.text,
                      description: _description.text,
                      addedOn: widget.note!.addedOn));
                }
              }, child: const Text("Save",style: TextStyle(color: AppColors.primaryDarkest),))
            ],
          ),
          body: BlocListener<AddNewNoteCubit, AddNewNoteState>(
            listener: (context, state) {
              if (state is AddedSuccessfully) {
                showToast("Added successfully!!!", ToastType.success);
                Navigator.pop(context, true);
              }
              if (state is Error) {
                showToast(state.msg, ToastType.error);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  TextField(
                    controller: _title,
                    decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(
                            color: AppColors.primaryDark,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0)),
                    scrollPadding: const EdgeInsets.all(8.0),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Flexible(
                    child: TextField(
                      controller: _description,
                      decoration: InputDecoration(
                        hintText: "Enter your text...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(
                            color: AppColors.primaryDark,
                            width: 2.0,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.primaryLight
                      ),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      scrollPadding: const EdgeInsets.all(20.0),
                      keyboardType: TextInputType.multiline,
                      maxLines: 10000,
                      autofocus: true,
                    ),
                  ),
                  // Expanded(child: ruledTextField()),
                  // Expanded(child: UnderlineTextField(style: TextStyle(), lines: 100,decoration: InputDecoration(contentPadding: const EdgeInsets.all(0),)))
                ],
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
        ),
      ),
    );
  }

  Widget ruledTextField() {
    return Stack(
      children: [
        for (int i = 0; i < 250; i++)
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: i * 22,
              left: 15,
              right: 15,
            ),
            height: 1,
            color: Colors.black,
          ),
        const SizedBox(
          height: 500,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              scrollPhysics: NeverScrollableScrollPhysics(),
              decoration: InputDecoration(border: InputBorder.none),
              style: TextStyle(
                fontSize: 18.0,
              ),
              keyboardType: TextInputType.multiline,
              expands: true,
              maxLines: null,
            ),
          ),
        ),
      ],
    );
  }
}

class UnderlineTextField extends StatelessWidget {
  const UnderlineTextField({
    required this.style,
    required this.lines,
    this.controller,
    this.decoration = const InputDecoration(isDense: true),
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int lines;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final textHeight = style.height ?? 20;
    return Stack(
      children: [
        TextField(
          style: style,
          controller: controller,
          decoration: decoration,
          // keyboardType: keyboardType,
          maxLines: null,
          expands: true,
          minLines: minLines,

          keyboardType: TextInputType.multiline,
        ),
        /*Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(

              lines,
                  (index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: textHeight),
                  const Divider(height: 1, thickness: 1),

                ],
              ),

            ),
          ),
        ),*/
      ],
    );
  }
}
