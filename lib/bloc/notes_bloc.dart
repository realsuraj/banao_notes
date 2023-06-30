import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../note.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  
  NotesBloc() : super(NotesInitial()) {
   on<LoadNoteCounter>((event, emit) async {
     List<Note> _notes = Note.notes;
       final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');
        try {
      
      var collection = FirebaseFirestore.instance.collection('notes');
var querySnapshot = await collection.get();
for (var notesSnapShot in querySnapshot.docs) {
  Map<String, dynamic> data = notesSnapShot.data();
  var content = data['content'];
  var title = data['title'];
  _notes.add(Note(title: title, content: content));
  }
  FirebaseFirestore.instance.disableNetwork();
        emit(NotesLoaded(notes: _notes));
  

      
      } catch (e) {
        emit(NotesLoaded(notes: []));
      }
    
   },);
   on<AddNotes>((event, emit) async {
    if(state is NotesLoaded){
      final state = this.state as NotesLoaded;
      emit(
        NotesLoaded(notes: List.from(state.notes)..add(event.note))
      );
    }
   },);
   on<RemoveNotes>((event, emit) {
    if(state is NotesLoaded){
      final state = this.state as NotesLoaded;
      emit(
        NotesLoaded(notes: List.from(state.notes)..remove(event.note))
      );
    }
   },);
  }
}
