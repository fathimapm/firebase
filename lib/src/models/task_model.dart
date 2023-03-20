class TaskModel{
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  bool isCompleted;
  String? id;

  TaskModel({required this.title,required this.description,required this.startDate,required this.endDate,
     required this.isCompleted,this.id});


  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        title: json["title"],
        description: json["description"],
        endDate: DateTime.parse(json["endDate"]),
        startDate: DateTime.parse(json["startDate"]),
        isCompleted: json["isCompleted"],
        id: json["id"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "description": this.description,
      "endDate": this.endDate.toIso8601String(),
      "startDate": this.startDate.toIso8601String(),
      "isCompleted": this.isCompleted,
      "id": this.id
    };
  }
//

}