import 'package:notes/cores/services/crud_operetion.dart';

import '../../app_imports.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screen = <Widget>[
    const Notes(),
    const Tasks(),
  ];

  void _selectedScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'notes'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'tasks'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _selectedScreen,
      ),
    );
  }
}

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final notes = FetchData();
  late Future<List<Note>> _notesFuture;
  final ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    _notesFuture = FetchData().getNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Consumer<NoteProvider>(builder: (context, noteProvider, _) {
            return Row(
              children: [
                if (noteProvider.openMark)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      apiServices.deleteApi(noteProvider.markedItemList);
                    },
                  ),
                Visibility(
                  visible: noteProvider.openMark == false,
                  child: const Row(
                    children: [
                      Icon(Icons.folder_copy_outlined),
                      SizedBox(width: 15),
                      Icon(Icons.settings),
                    ],
                  ),
                ),
              ],
            );
          })
        ],
      ),
      body: SafeArea(
          top: true,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search notes',
                    contentPadding: const EdgeInsets.all(13),
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Consumer<NoteProvider>(
                  builder: (context, noteProvider, _) {
                    return Row(children: [
                      Options(
                          text: 'all',
                          onTap: () => noteProvider.oneOption(0),
                          isSelected: noteProvider.selectedIndex == 0),
                      const SizedBox(width: 15),
                      Options(
                          text: 'Unnamed folder',
                          onTap: () => noteProvider.oneOption(1),
                          isSelected: noteProvider.selectedIndex == 1),
                      const SizedBox(width: 15),
                      Options(
                          text: 'Uncategorized',
                          onTap: () => noteProvider.oneOption(2),
                          isSelected: noteProvider.selectedIndex == 2),
                    ]);
                  },
                ),
                const SizedBox(height: 20),
                FutureBuilder<List<Note>>(
                  future: _notesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print('${snapshot.error}');
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No users found'));
                    }
                    final notes = snapshot.data;
                    print('Fetched Notes: $notes');
                    return Expanded(
                      child: ListView.separated(
                        itemCount: notes!.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10.0);
                        },
                        itemBuilder: (context, index) {
                          return Consumer<NoteProvider>(
                            builder: (context, noteProvider, _) {
                              return GestureDetector(
                                onLongPress: () {
                                  noteProvider
                                      .openItemMark(); // Mark the current item
                                },
                                onTap: () {
                                  if (noteProvider.openMark == true) {
                                    noteProvider.markItem(index);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: cloudColor),
                                  child: ListTile(
                                    trailing: Visibility(
                                      visible: noteProvider.openMark,
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: noteProvider.markedItemList
                                                  .contains(index)
                                              ? secondaryColor
                                              : backgroundColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: FittedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: noteProvider.markedItemList
                                                    .contains(index)
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 50,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(notes[index].title),
                                    subtitle: Text(notes[index].content),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          backgroundColor: kWarninngColor,
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateNote()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {
  const Options({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });

  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 3),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent,
          // Change color when selected
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: isSelected ? 15 : 14, // Change font size when selected
              color: isSelected
                  ? Colors.white
                  : Colors.white60, // Change text color when selected
            ),
          ),
        ),
      ),
    );
  }
}

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
