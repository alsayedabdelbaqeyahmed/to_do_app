// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_app/model/database/local_data_base.dart';
import 'package:to_do_app/model/database/tasks_model.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<TaskModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return FutureBuilder(
        future: getData(),
        builder: (context, data) {
          return !data.hasData || data.hasError || tasks.isEmpty
              ? SizedBox(
                  //height: size.maxHeight,
                  width: size.maxWidth,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.only(top: size.maxHeight * 0.04),
                    child: Image.asset(
                      'assets/images/homepagelogo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(tasks[index].taskName!),
                        Text(tasks[index].description!),
                        Text(tasks[index].date!),
                        Text(tasks[index].category!),
                      ],
                    );
                  },
                  itemCount: tasks.length,
                );
        },
      );
    });
  }

  Future<List<TaskModel>> getData() async {
    var dataBase = LocalDataBase.db;
    await dataBase.getUserData().then((value) => tasks = value);
    return tasks;
  }
}
