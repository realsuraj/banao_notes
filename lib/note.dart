import 'package:equatable/equatable.dart';

class Note extends Equatable{
  String id;
  String title;
  String content;
  String isDeleted;
  String? docId;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.isDeleted,
    this.docId
  });

  factory Note.fromSnapshot(Map<String, dynamic> snapshot) {
    return Note(
      id: snapshot['id'],
      title: snapshot['title'],
      content: snapshot['content'],
      isDeleted: snapshot['isDeleted'],
      docId: snapshot['docId']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'isDeleted': isDeleted,
      'docId': docId,
    };
  }

  @override
  List<Object?> get props => [id,title,content,isDeleted,docId];

  static List<Note> notes = [
       
  ];

  static fromJson(data) {}
}


