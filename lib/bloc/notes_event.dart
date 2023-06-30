part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNoteCounter extends NotesEvent {}



class RemoveNotes extends NotesEvent {
   final Note note;
  const RemoveNotes(this.note);

  @override
  List<Object> get props => [note];
}

class AddNotes extends NotesEvent {
  final Note note;
  const AddNotes(this.note);

  @override
  List<Object> get props => [note];
}