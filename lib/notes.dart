import 'package:banao_notes/add_notes.dart';
import 'package:banao_notes/bloc/notes_bloc.dart';
import 'package:banao_notes/edit_notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});
  static bool addNewData = false;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String isDeletedState = "false";
  String noteText = "Notes";
  bool isDisplayNotes = true;
 
   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
     if(NoteScreen.addNewData == true){
      Fluttertoast.showToast(
        msg: "notes added successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
      NoteScreen.addNewData = false;
     }
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SafeArea(
        child: Center(child: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
          if(state is NotesInitial){
            return const CircularProgressIndicator(color: Colors.green,);
      
          }
          if(state is NotesLoaded){
            return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Text(
              "$noteText",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
              ),
               Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child:IconButton(onPressed: (){
          setState(() {
            isDeletedState = (isDeletedState == "false")?isDeletedState = "true":isDeletedState = "false";
            noteText = (noteText == "Notes")?"Trash Notes":"Notes";
          });
        },icon: Icon(Icons.backup))
          ),
            ],
          ),
          Expanded(
        child: ListView.builder(
          itemCount: state.notes.length,
          itemBuilder: (BuildContext context, int index) {
            Note note = state.notes[index];
            return Visibility(
                visible: (note.isDeleted == isDeletedState)?true:false,
  
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: (){
                     
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditNotes(content: note.content, title: note.title)),
  );
                      
                  },
                  child: Stack(
                    children: [
                       Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          note.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        
                      
                      )
                      ],
                    ),
                 Visibility(
                  visible: (note.isDeleted == "false")?true:false,
                   child: Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: (){
                        context.read<NotesBloc>().add(RemoveNotes(Note(id: note.id, title: note.title, content: note.content, isDeleted: "true")));
                      updateNoteInFirestore(Note(id: note.id, title: note.title, content: note.content, isDeleted: "true",docId: note.docId));
                       Fluttertoast.showToast(
                      msg: "Note Deleted successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                      }, 
                      icon: Icon(Icons.delete))),
                 )
                    ]),
                ),
              ),
            );
          },
        ),
          ),
        Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: FloatingActionButton(
          onPressed: () async {
              final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotesScreen()),
          );
          if (result == 'success') {
            print("success");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Note added successfully!'),
              ),
            );
          }
          
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
        ),
      ),
    ),
        ],
      );
      
          }
          else{
            return const Text("something went wrong");
          }
        }
        ,)),
      ),
    );


  }

   void _deleteNote(Note note) {
    setState(() {
      note.isDeleted = "true";
    });
  }

  
    Future<void> updateNoteInFirestore(Note updatedNote) async {
      print(updatedNote);
  try {
    final CollectionReference notesCollection = FirebaseFirestore.instance.collection('notes');
    await notesCollection.doc(updatedNote.docId).update({
      'isDeleted': updatedNote.isDeleted,
      'id': updatedNote.id,
      'title': updatedNote.title,
      'content': updatedNote.content,
    });
  } catch (e) {
    print('Failed to update note: $e');
    // Handle the error as needed
  }
}
  
 
}


