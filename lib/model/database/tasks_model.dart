import 'package:to_do_app/model/constants/constants.dart';

class TaskModel {
  String? taskName;
  String? description;
  String? date, time;
  String? category;
  String? status;
  int? id;

  TaskModel({
    this.category,
    this.date,
    this.description,
    this.taskName,
    this.id,
    this.time,
    this.status,
  });

  toJason() {
    return {
      conname: taskName,
      condesc: description,
      condate: date,
      concateg: category,
      'id': id,
      contime: time,
      constatus: status
    };
  }

  TaskModel.fromJason(Map<String, dynamic> map) {
    taskName = map[conname];
    description = map[condesc];
    date = map[condate];
    category = map[concateg];
    id = map['id'];
    time = map[contime];
    status = map[constatus];
  }
}
