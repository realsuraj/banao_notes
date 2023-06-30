import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notes_bloc.dart';
import 'notes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesBloc()..add(LoadNoteCounter()),
        )
      ],
      child: MaterialApp(
        title: 'Firebase Database Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NoteScreen(),
      ),
    );
  }
}
