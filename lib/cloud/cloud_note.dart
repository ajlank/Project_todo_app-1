
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/cloud/cloud_storage_constants.dart';

@immutable
class CloudNote {
  
  final String documentId;
  final String userId;
  final String userText;
  final DateTime createdAt;

  const CloudNote({required this.documentId,
   required this.userId, required this.userText, required this.createdAt});

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String,dynamic>>snapshot):
  documentId=snapshot.id,
  userId=snapshot.data()[userIdFieldName],
  userText=snapshot.data()[textFieldName] as String,
  createdAt=(snapshot.data()['createdAt'] as Timestamp).toDate();
 
  @override
  String toString() {
    return '$documentId, $userId $userText $createdAt';
  }
 
}