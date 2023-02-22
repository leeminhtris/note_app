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
  List<Note> notes = [];
  var items = [];

  void refresh() async {
    noteController.getALlNotes().then((value) => {
          setState(() {
            notes = value;
            items = notes;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void search(String keyword) {
    setState(() {
      if (keyword != null) {
        items = notes
            .where((element) =>
                element.title!.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      } else {
        setState(() {
          items = notes;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            buildTitle(),
            const SizedBox(height: 10),
            buildSearchField(),
            const SizedBox(height: 10),
            buildBodyPage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FormNote()));
          });
        },
        tooltip: 'Tạo ghi chú',
        child: const Icon(Icons.add),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 1 / 20,
        color: Colors.orange,
        child: Text("${notes.length.toString()} ghi chú"),
      ),
    );
  }

  Widget buildTitle() {
    return const Text(
      "Ghi Chú",
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildSearchField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Tìm kiếm",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      onChanged: (value) {
        setState(() {
          search(value);
        });
      },
    );
  }

  Widget buildBodyPage() {
    return ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            color: Colors.orange[200],
            margin: const EdgeInsets.all(5),
            child: ListTile(
                title: Text(items[index].title!),
                subtitle: Text(items[index].description!),
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
                                  builder: (context) =>
                                      FormNote(selectedNote: items[index])));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            noteController.deleteNote(items[index]);
                            refresh();
                            messageSackBar(context, "Xoá thành công");
                          });
                        },
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
