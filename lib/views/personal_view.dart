import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/cloud/cloud_note.dart';
import 'package:todoapp/cloud/firebase_cloud_storage.dart';
import 'package:todoapp/main.dart';

class PersonalView extends StatefulWidget {
  const PersonalView({super.key});

  @override
  State<PersonalView> createState() => _PersonalViewState();
}
String get userId=>FirebaseAuth.instance.currentUser!.uid;
class _PersonalViewState extends State<PersonalView> {
  Set<int> selectedIndex = {};
  
  bool isToday(DateTime date){
    final presentDay=DateTime.now();
    final today=DateTime(presentDay.year,presentDay.month,presentDay.day);
    final givenDataDate=DateTime(date.year,date.month,date.day);
    
    if(today==givenDataDate){
      return true;
    }else{
      return false;
    }
  }
  
  bool isPrevious(DateTime date){
   final presentDay=DateTime.now();
   final previousDay=DateTime(presentDay.year,presentDay.month,presentDay.day-1);
   final givenDataDate=DateTime(date.year,date.month,date.day);

   if(previousDay==givenDataDate){
    return true;
   }else{
    return false;
   }
  
  }

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
                        child:FutureBuilder(
                          future: context.read<PersonalNoteProvider>().lengthOfNote(userId: userId),
                           builder: (context, snapshot) {
                             if(snapshot.connectionState==ConnectionState.waiting){
                              return Text('Loading..');
                             }else if(snapshot.hasError){
                              return Text('Error');
                             }else{
                              final count=snapshot.data??'0';
                              return Text(
                                  '$count Tasks',
                                  style: TextStyle(fontSize: 13),
                                );
                             }     
                           }
                      )
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
                    stream: value.fetchNotes(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          if (snapshot.hasData) {
                            final data = snapshot.data as Iterable<CloudNote>;
                            
                            final todaysNote=data.where((note) =>isToday(note.createdAt)).toList();
                            final previousNote=data.where((note) =>isPrevious(note.createdAt)).toList();
                            final oldNotes=data.where((note) =>!isToday(note.createdAt) &&!isPrevious(note.createdAt)).toList();
                            
                             
                             final combinedList=[
                              if(todaysNote.isNotEmpty) 'Today',
                              ...todaysNote,

                              if(previousNote.isNotEmpty) 'Previous',
                              ...previousNote,
                              
                              if(oldNotes.isNotEmpty) 'Old Tasks',
                              ...oldNotes,

                             ];

                            return ListView.builder(
                              itemCount: combinedList.length,
                              itemBuilder: (context, index) {
                               
                                final item = combinedList[index];
                                  if (item is String) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(item,
                                          style: TextStyle(
                                              fontSize: 13, fontWeight: FontWeight.w400)),
                                    );
                                  }
                                  final note=item as CloudNote;
                                
                                  
                                return Column(
                                  children: [
                                  
                                    ListTile(
                                      leading: Checkbox(
                                        value: selectedIndex.contains(index),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value == true) {
                                              selectedIndex.add(index);
                                            }else{
                                              selectedIndex.remove(index);
                                            }
                                          });
                                        },
                                      ),
                                      title: Text(note.userText),
                                     
                                      trailing: selectedIndex.contains(index)
                                          ? IconButton(
                                              onPressed: () {
                                                
                                                context
                                                    .read<PersonalNoteProvider>()
                                                    .deleteNote(
                                                      documentId: note.documentId,
                                                    );
                                              },
                                              icon: Icon(Icons.delete),
                                            )
                                          : SizedBox.shrink(),
                                    ),
                                    Divider(
                                      indent: 32.2,
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
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
