import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/main.dart';

class WritePersonal extends StatefulWidget {
  const WritePersonal({super.key});

  @override
  State<WritePersonal> createState() => _WritePersonalState();
}

class _WritePersonalState extends State<WritePersonal> {

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
              context.read<PersonalNoteProvider>().createNewNote(text: userText);
            }, icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}