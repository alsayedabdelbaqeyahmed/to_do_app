// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/controller/bloc/tasks_states.dart';
import 'package:to_do_app/model/constants/animated_page-route.dart';
import 'package:to_do_app/model/constants/constants.dart';

import 'package:to_do_app/model/database/local_data_base.dart';
import 'package:to_do_app/model/database/tasks_model.dart';
import 'package:to_do_app/view/add_new_tasks/add_new_tasks.dart';
import 'package:to_do_app/view/deleted/deleted.dart';
import 'package:to_do_app/view/done/done.dart';
import 'package:to_do_app/view/home/my_home_page.dart';
import 'package:to_do_app/view/tasks/tasks.dart';

class TasksCubit extends Cubit<TasksStates> {
  TasksCubit() : super(TasksAddStates());

  static TasksCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  final database = LocalDataBase.db;
  bool isDone = false;

  List<Widget> pages = const [Tasks(), DoneTasks(), ArchivedTasks()];

  List<String> tittles = [
    'Tasks',
    'Done',
    'Deleted',
  ];
  // list of tasks
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> doneTasks = [];
  List<Map<String, dynamic>> archivedTasks = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(TasksBottomBarStates());
  }

  void isDonestate(bool isDonestate) {
    isDone = isDonestate;
    emit(TasksAddStates());
  }

  Future getData(BuildContext context) async {
    var dataBase = LocalDataBase.db;
    print(doneTasks);
    print(archivedTasks);

    await dataBase.getUserData().then((value) {
      tasks = [];
      doneTasks = [];
      archivedTasks = [];
      value.forEach(
        (element) {
          if (element[constatus] == condone.trim()) {
            doneTasks.add(element);
          } else if (element[constatus] == conarchived.trim()) {
            archivedTasks.add(element);
          } else if (element[constatus] == connew.trim()) {
            tasks.add(element);
            print(doneTasks);
          }
        },
      );
      emit(TasksGetStates());
    });
    return tasks;
  }

  void initDataBase(BuildContext context) {
    database.initDB();
    getData(context);
    print('app initial state');
    emit(TasksAddStates());
  }

  void addTasks(TaskModel tasks, BuildContext context) {
    database.insertData(tasks).then((value) {
      emit(TasksAddStates());
      getData(context);
    });
    print('add tasks state');
  }

  void updateTaskStatus(String? status, int? id, BuildContext context) {
    database.updateStatus(status, id).then((value) {
      getData(context).then((value) {
        emit(TasksEditStates());
      });
    });
  }

  void deletetask(int? id, BuildContext context) {
    database.deleteTask(id).then((value) {
      getData(context);
      print('object');
      emit(TasksDeleteStates());
    });
  }
}
