import 'package:flutter/material.dart';
import 'package:note/src/component/message.dart';
import '../controller/note_controller.dart';
import '../model/note.dart';
import 'form_note.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchText = TextEditingController();
  NoteController noteController = NoteController();

  bool isLoading = false;
  List<Note> notes = [];
  List<Note> filteredList = [];

  void refreshNotes() async {
    final data = await noteController.getALlNotes();
    setState(() {
      if (data != null) {
        notes = data;
        print(notes.toString());
        isLoading = false;
      } else {
        throw Exception("Lỗi data == null");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  void filterList(value) {
    setState(() {
      filteredList = notes
          .where(
              (text) => text.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              "Ghi Chú",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Tìm kiếm",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onChanged: (value) {
                filterList(value);
                print(value);
              },
            ),
            const SizedBox(height: 10),
            // FutureBuilder(
            //        future: noteController.getALlNotes(),
            //        builder: (BuildContext context,
            //            AsyncSnapshot<dynamic> snapshot) {
            //          if (snapshot.data) {
            //            if (!isLoading) {
            //              notes = snapshot.data;
            //              filteredList = notes;
            //              isLoading = !isLoading;
            //            }
            //          }
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notes.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(10),
                child: ListTile(
                    title: Text(notes[index].title!),
                    subtitle: Text(notes[index].description!),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormNote(
                                          selectedNote: notes[index])));
                              print("sửa");
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              noteController.deleteNote(notes[index]);
                              messageSackBar(context, "Xoá thành công");
                              refreshNotes();
                            },
                          ),
                        ],
                      ),
                    )),
              ),
              // );
              // },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          setState(() {
            print("thêm");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FormNote()));
            refreshNotes();
          });
        },
        tooltip: 'Tạo ghi chú',
        child: const Icon(Icons.add),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 1 / 20,
        color: Colors.orange,
        child: Text("Tổng số ghi chú: ${notes.length.toString()}"),
      ),
    );
  }
}
