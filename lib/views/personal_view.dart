import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/cloud/cloud_note.dart';
import 'package:todoapp/main.dart';

class PersonalView extends StatefulWidget {
  const PersonalView({super.key});

  @override
  State<PersonalView> createState() => _PersonalViewState();
}

class _PersonalViewState extends State<PersonalView> {
  bool? isChecked=false;
  int selectedValue=0;
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
            SizedBox(
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
                  return StreamBuilder(
                    stream:value.fetchNotes(),
                     builder: (context, snapshot) {
                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                         if(snapshot.hasData){
                          final data=snapshot.data as Iterable<CloudNote>;
                          return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final note=data.elementAt(index);
                                return ListTile(
                                  leading: Checkbox(
                                    value: selectedValue==index,
                                    onChanged: (value) {
                                      if(value!){
                                        setState(() {
                                          selectedValue=index;
                                        });
                                      
                                      }
                                      
                                    },
                                  ),
                                  title: Text(note.userText),
                                  
                                  trailing: (selectedValue==index)?IconButton(onPressed: () {
                                    context.read<PersonalNoteProvider>().deleteNote(documentId: note.documentId);
                                  }, icon: Icon(Icons.delete)):Text(''),
                                );

                              },
                            
                          );
                          
                         }else{
                          return const CircularProgressIndicator();
                         }
                        default:
                        return const CircularProgressIndicator();
                        
                      }  
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
