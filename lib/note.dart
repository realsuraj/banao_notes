import 'package:equatable/equatable.dart';

class Note extends Equatable{
  String? id;
  String title;
  String content;

  Note({
    this.id,
    required this.title,
    required this.content,
  });

  factory Note.fromSnapshot(Map<String, dynamic> snapshot) {
    return Note(
      id: snapshot['id'],
      title: snapshot['title'],
      content: snapshot['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }

  @override
  List<Object?> get props => [id,title,content];

  static List<Note> notes = [
       
  ];

  static fromJson(data) {}
}


