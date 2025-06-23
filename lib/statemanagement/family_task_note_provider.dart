import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/cloud1/cloud_note.dart';
import 'package:todoapp/cloud3/firebase_family_cloud_storage.dart';

class FamilyTaskNoteProvider extends ChangeNotifier{

   final FirebaseFamilyCloudStorage cloudStorage=FirebaseFamilyCloudStorage();
   int totalFamilyTask=0;
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
    totalFamilyTask=lengtH;
    notifyListeners();
    return lengtH;
    
  }
 
 int get getTotalFamilyTask=>totalFamilyTask;
 

}