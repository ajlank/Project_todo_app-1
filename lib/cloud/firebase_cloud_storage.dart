import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/cloud/cloud_note.dart';
import 'package:todoapp/cloud/cloud_note_excpetion.dart';
import 'package:todoapp/cloud/cloud_storage_constants.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('tododaily');

   Future<void> deleteNote({
    required String documentId,
  }) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String updatedText,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: updatedText});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> getAllNotes({required String userId}) {
    try {
      return notes.orderBy('createdAt', descending: true).snapshots().map(
        (event) => event.docs
            .map((doc) => CloudNote.fromSnapshot(doc))
            .where((note) => note.userId == userId),
      );
    } catch (e) {
      throw CouldNotGetNoteException();
    }
  }

  Future<Iterable<CloudNote>> getNotes({required String userId}) async {
    try {
      return notes
          .where(userIdFieldName, isEqualTo: userId)
          .get()
          .then(
            (value) => value.docs.map((doc) => CloudNote.fromSnapshot(doc)),
          );
    } catch (e) {
      throw CouldNotGetNoteException();
    }
  }

  Future<CloudNote> createNewNote({required String userId, required String userText}) async {
    try {
      final document = await notes.add({
        userIdFieldName: userId,
        textFieldName: userText,
        'createdAt':FieldValue.serverTimestamp()
      });

      final fetchedNote = await document.get();
      final data=fetchedNote.data() as Map<String,dynamic>;
      return CloudNote(
        documentId: fetchedNote.id,
        userId: userId,
        userText: userText,
        createdAt: (data['createdAt'] as Timestamp).toDate()
      );
    } catch (e) {
      throw CouldNotCreateNoteException();
    }
  }
}
