import 'package:flutter/material.dart';
import 'package:note/src/model/note.dart';
import '../controller/note_controller.dart';

class FormNote extends StatefulWidget {
  final Note? selectedNote;
  const FormNote({super.key, this.selectedNote});

  @override
  State<FormNote> createState() => _FormNoteState();
}

class _FormNoteState extends State<FormNote> {
  // static final navigatorKey = GlobalKey<NavigatorState>();
  //sử dụng để truy cập form
  final formKey = GlobalKey<FormState>();
  NoteController noteController = NoteController();

  Note note = Note();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: navigatorKey,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          actions: [
            ElevatedButton(
              onPressed: () {
                save();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Lưu"),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            //form như group tập hợp TextFormField để save, validate
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: widget.selectedNote?.title,
                  maxLines: 1,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: "Tiêu đề"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (widget.selectedNote == null) {
                      if (value == null || value.isEmpty) {
                        return "Tiêu đề không được để trống";
                      }
                    }
                  },
                  onSaved: (value) {
                    if (widget.selectedNote != null) {
                      setState(() {
                        widget.selectedNote!.title = value;
                      });
                    } else {
                      setState(() {
                        note.title = value;
                      });
                    }
                  },
                ),
                TextFormField(
                  initialValue: widget.selectedNote?.description,
                  maxLines: null,
                  decoration: const InputDecoration(hintText: "Nội dung"),
                  onSaved: (value) {
                    if (widget.selectedNote != null) {
                      setState(() {
                        widget.selectedNote!.description = value;
                      });
                    } else {
                      setState(() {
                        note.description = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  bool validate() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void save() {
    if (validate()) {
      if (widget.selectedNote != null) {
        noteController.updateNote(widget.selectedNote!);
      } else {
        noteController.addNote(note);
        print('Note==========>$note');
      }
      Navigator.pop(context);
    }
  }
}
