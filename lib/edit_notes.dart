import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notes_bloc.dart';

class EditNotes extends StatefulWidget {
  final String content, title;
  const EditNotes({super.key, required this.content, required this.title});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
 
  
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String title = "",content = "";

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Detail'),
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
              hintText: '${widget.title}',
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
          Text("${widget.content}")
        ],
      ),
    ),
     Divider(
            height: 0.03,
            color: Colors.black,
          ),
          SizedBox(height: 20,),
   
  ],
)

    ))));
  
  }
}