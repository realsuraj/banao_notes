import 'package:banao_notes/add_notes.dart';
import 'package:banao_notes/bloc/notes_bloc.dart';
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
 
   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
     if(NoteScreen.addNewData == true){
      Fluttertoast.showToast(
        msg: "notes added successfully",
        toastLength: Toast.LENGTH_SHORT,
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
         
          
          Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Text(
          "Notes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
          ),
          Expanded(
        child: ListView.builder(
          itemCount: state.notes.length,
          itemBuilder: (BuildContext context, int index) {
            Note note = state.notes[index];
            return Container(
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
                   showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(note.title),
                        content: Text(note.content),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                       },
                  );
                    
                },
                child: Column(
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
                    ),
                  ],
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
 
}
