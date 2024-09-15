import 'package:notes/View-model/State/form_validator.dart';
import 'package:notes/View/Screen/add_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListDemo extends StatefulWidget {
  const ListDemo({super.key});

  @override
  State<ListDemo> createState() => _ListDemoState();
}

class _ListDemoState extends State<ListDemo> {
  List<String> item = ['item', 'item 2', 'item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FormValidator>(
        builder: (context, formValidator, _) {
          return ListView.builder(
            itemCount: formValidator.userCredentialsList.length,
            itemBuilder: (context, index) {
              final userData = formValidator.userCredentialsList[index];
              return ListTile(
                title: Text(userData['email'] ?? ''),
                subtitle: Text(userData['password'] ?? ''),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
