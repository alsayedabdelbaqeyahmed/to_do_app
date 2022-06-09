import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/controller/bloc/tasks_states.dart';
import 'package:to_do_app/model/constants/animated_page-route.dart';

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

  List<Widget> pages = const [Tasks(), Done(), Deleted()];

  List<String> tittles = [
    'Tasks',
    'Done',
    'Deleted',
  ];
  // list of tasks
  List<Map<String, dynamic>> tasks = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(TasksBottomBarStates());
  }

  void isDonestate(bool isDonestate) {
    isDone = isDonestate;
    emit(TasksAddStates());
  }

  void initDataBase() {
    database.initDB();
    print('app initial state');
    emit(TasksAddStates());
  }

  void addTasks(TaskModel tasks, BuildContext context) {
    database.insertData(tasks).then((value) {
      emit(TasksAddStates());
      getData().then((value) => Navigator.pushAndRemoveUntil(
          context,
          AnimatedPageRoute(
            beginDx: 10.0,
            beginDy: 10.0,
            endDx: 0.0,
            endDy: 0.0,
            duration: const Duration(seconds: 0),
            curve: Curves.ease,
            widget: MyHomePage(),
          ),
          (_) => false));
    });
    print('add tasks state');
  }

  Future<List<Map<String, dynamic>>> getData() async {
    var dataBase = LocalDataBase.db;
    await dataBase.getUserData().then(
      (value) {
        tasks = value;
        emit(TasksGetStates());
      },
    );
    print('get tasks state');
    return tasks;
  }
}
