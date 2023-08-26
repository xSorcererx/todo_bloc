// To do model

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoModel {
  // defining the model
  int? docId;
  final String todoTitle;
  final String description;
  final String category;
  final String date;
  final String time;

  TodoModel({
    this.docId,
    required this.todoTitle,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
  });

  // function to convert the to do model to Map data
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'todoTitle': todoTitle,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
    };
  }

  /*
    function to convert the json data, taken usually from the API,
    into To do model
  */
  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        docId: json["id"],
        todoTitle: json["todo_title"],
        description: json["description"],
        date: json["date"],
        time: json["time"],
        category: json["category"],
      );

  /*
    function to convert the to do model to json data.
    It is used in cases where data needs to be sent to 
    the API
  */
  Map<String, dynamic> toJson() => {
        // "id": docId,
        "todo_title": todoTitle,
        "description": description,
        "date": date,
        "time": time,
        "category": category,
      };
}
