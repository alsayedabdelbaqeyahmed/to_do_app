import 'package:to_do_app/model/constants/constants.dart';

class TaskModel {
  String? taskName;
  String? description;
  String? date, time;
  String? category;
  int? id;

  TaskModel({
    this.category,
    this.date,
    this.description,
    this.taskName,
    this.id,
    this.time,
  });

  toJason() {
    return {
      name: taskName,
      desc: description,
      condate: date,
      categ: category,
      'id': id,
      contime: time
    };
  }

  TaskModel.fromJason(Map<String, dynamic> map) {
    taskName = map[name];
    description = map[desc];
    date = map[condate];
    category = map[categ];
    id = map['id'];
    time = map[contime];
  }
}
