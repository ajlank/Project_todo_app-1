class CloudNoteExcpetion implements Exception{
  const CloudNoteExcpetion();
}

class CouldNotCreateNoteException extends CloudNoteExcpetion{}
class CouldNotGetNoteException extends CloudNoteExcpetion{}
class CouldNotUpdateNoteException extends CloudNoteExcpetion{}
class CouldNotDeleteNoteException extends CloudNoteExcpetion{}
class CouldNotGetNoteLengthException extends CloudNoteExcpetion{}