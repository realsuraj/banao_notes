import 'package:banao_notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notes_bloc.dart';
import 'note.dart';

class AddNotesScreen extends StatelessWidget {
  AddNotesScreen({super.key});

  String title = "",content = "";

  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();


  void _addNote() {
    String title = _titleController.text;
    String content = _contentController.text;
    Note note = Note(title: title, content: content);

    _notesCollection.add(note.toMap());

    _titleController.clear();
    _contentController.clear();
  }

 

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: SafeArea(
        child: Center(child: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) =>
      
      
       Column(
  children: [
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            maxLines: 1,
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Title',
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) {
              title = value;
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(
              hintText: 'Take a note',
              border: InputBorder.none,
            ),
            maxLines: null,
            onChanged: (value) {
              content = value;
            },
          ),
        ],
      ),
    ),
     Divider(
            height: 0.03,
            color: Colors.black,
          ),
          SizedBox(height: 20,),
    ElevatedButton(
      onPressed: () {
        _addNote();
        NoteScreen.addNewData = true;

        Note _note = Note(id: "12", title: title, content: content);

        context.read<NotesBloc>().add(AddNotes(_note));
        

         Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen()),
    );
      },
      child: Text('Add Note'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
)

    ))));
  }
}
