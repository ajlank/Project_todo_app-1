import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/statemanagement/family_task_note_provider.dart';


class WriteFamilyTask extends StatefulWidget {
  const WriteFamilyTask({super.key});

  @override
  State<WriteFamilyTask> createState() => _WriteFamilyTaskState();
}

class _WriteFamilyTaskState extends State<WriteFamilyTask> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12,0,0,0),
              child: const Text("What tasks are you planning to perform?",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
            ),
          
            TextField(
              controller: _textController,
              maxLines: null,
            
            ),
            IconButton(onPressed: () {
              final userText=_textController.text;
              if(userText.isNotEmpty){
               context.read<FamilyTaskNoteProvider>().createNewNote(text: userText);
              }else{
                return;
              }
            }, icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}