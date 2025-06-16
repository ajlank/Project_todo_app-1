
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/cloud/cloud_storage_constants.dart';

@immutable
class CloudNote {
  
  final String documentId;
  final String userId;
  final String userText;
  
  const CloudNote({required this.documentId, required this.userId, required this.userText});

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String,dynamic>>snapshot):
  documentId=snapshot.id,
  userId=snapshot.data()[userIdFieldName],
  userText=snapshot.data()[textFieldName] as String;
 
  @override
  String toString() {
    return '$documentId, $userId $userText';
  }
 
}