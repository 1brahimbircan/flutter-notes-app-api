class Note {
  String? id;
  String? userid;
  String? title;
  String? content;
  String? priority;
  String? category;
  DateTime? dateadded;

  Note({this.id,this.userid,this.category, this.priority,this.title,this.content,this.dateadded});

  factory Note.fromMap(Map<String,dynamic> map){
    return Note(
      id: map["id"],
      userid: map["userid"],
      category: map["category"],
      priority: map["priority"],
      title: map["title"],
      content: map["content"],
      dateadded: DateTime.tryParse(map["dateadded"]),
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "id":id,
      "userid":userid,
      "category":category,
      "priority":priority,
      "title":title,
      "content":content,
      "dateadded":dateadded!.toString()
    };
  }
}