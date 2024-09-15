import 'package:notes/app_imports.dart';



class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final notes = ApiServices();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    final note = Note(
        title: titleController.text,
        content: noteController.text,
        timestamp: DateTime.timestamp());
    if(titleController.text.isEmpty || noteController.text.isEmpty){
      debugPrint('empty');
    }else{
      notes.putApi(null, note);
    }

    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_outlined),
            onPressed: () {},
          ),
          const PopupMenu()
        ],
      ),
      body:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white24),
                    contentPadding: EdgeInsets.all(1),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),
                ),
                SizedBox(height: 10,),
                Opacity(
                    opacity: 0.5,
                    child: Text('${DateTime.now().toLocal().toString().substring(0, 16)} |'
                        ' ${noteController.text.length} characters')),
                SizedBox(height: 10,),
                TextField(
                  controller: noteController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Start typing....',
                    hintStyle: TextStyle(color: Colors.white24),
                    contentPadding: EdgeInsets.all(1),
                    border: InputBorder.none,
                  ),
                ),

              ],
                  ),
          ))
    );
  }
}

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          switch (value) {
            case 0:
              print('object');
            case 1:
              print('menu');
          }
        },
        itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text('Settings'),
                    ],
                  )
              ),
          const PopupMenuItem(
              value: 0,
              child: Row(
                children: [
                  Icon(Icons.menu),
                  SizedBox(width: 10),
                  Text('menu'),
                ],
              )
          )
            ]
    );
  }
}
