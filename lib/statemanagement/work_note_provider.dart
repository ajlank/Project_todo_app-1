import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/cloud1/cloud_note.dart';
import 'package:todoapp/cloud2/firebase_work_cloud_storage.dart';

class WorkNoteProvider extends ChangeNotifier{
  final FirebaseWorkCloudStorage cloudStorage=FirebaseWorkCloudStorage();
 
   final List<CloudNote> _notes=[];

  
   UnmodifiableListView<dynamic> get items => UnmodifiableListView(_notes);
  
   Future<CloudNote>createNewNote({required String text})async{
    final userId=FirebaseAuth.instance.currentUser!.uid;
    final newNotes=await cloudStorage.createNewNote(userId: userId,userText: text);
   
    _notes.add(newNotes);
    notifyListeners();
    return newNotes;
   }

  Stream<Iterable<CloudNote>>fetchNotes(){
    final userId=FirebaseAuth.instance.currentUser!.uid;
    final fetchedNote=cloudStorage.getAllNotes(userId: userId);
     notifyListeners();
     return fetchedNote;
  }

  Future<void>deleteNote({required String documentId})async{
    await cloudStorage.deleteNote(documentId: documentId);
     
    notifyListeners();
  }

  Future<int>lengthOfNote({required String userId})async{
    final lengtH=await cloudStorage.notesLength(userId: userId);
    notifyListeners();
    return lengtH;
    
  }

}