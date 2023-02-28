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
  //nhập vào thanh tìm kiếm
  TextEditingController searchText = TextEditingController();
  NoteController noteController = NoteController();
  List<Note> notes = [];
  List<Note> items = [];

  bool data = false;
  void refresh() async {
    //lấy ra tất cả ghi chú
    noteController.getALlNotes().then((value) => {
          setState(() {
            notes = value;
            items = notes;
            if (items.isNotEmpty) {
              data = true;
            } else {
              data = false;
            }
          })
        });
  }

  @override
  void initState() {
    super.initState();
      refresh();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    refresh();
  }

  void search(String keyword) {
    setState(() {
      // nếu có nhập keyword lấy ra ghi chú vào items
      if (keyword.isNotEmpty) {
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
      // key: navigatorKey,
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormNote()));
        },
        tooltip: 'Tạo ghi chú',
        child: const Icon(Icons.add),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 1 / 15,
        color: Colors.orange,
        child: Text("${items.length.toString()} ghi chú"),
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

  Widget buildBodyPage() => data
      ? Container(
          padding: const EdgeInsets.only(bottom: 50),
          child: FutureBuilder<List<Note>>(
            future: noteController.getALlNotes(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("lỗi"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
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
                                          builder: (context) => FormNote(
                                              selectedNote: items[index])));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  noteController.deleteNote(items[index]);
                                  refresh();
                                  messageSackBar(context, "Xoá thành công");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      : const Center(child: Text(""));
}
