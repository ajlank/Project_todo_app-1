import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/main.dart';

class PersonalView extends StatelessWidget {
  const PersonalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (context) {
                return [];
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Container(
              height: 200,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                    child: CircleAvatar(
                      child: Icon(Icons.person, color: Colors.deepOrange),
                    ),
                  ),
                  SizedBox(height: 13),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                    child: const Text(
                      '9 Tasks',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                    child: const Text(
                      'Personal',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Slider(value: 0.7, onChanged: (value) {}),
                ],
              ),
            ),

            Expanded(
              child: Consumer<PersonalNoteProvider>(
                builder: (context, value, child) {
                  final notess = value.notes;
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(21, 0, 0, 0),
                    itemCount: notess.length,
                    itemBuilder: (context, index) {
                      final note = notess.elementAt(index);
                     return ListTile(
                      title: Text(note.text),
                     );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/writePersonal');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
