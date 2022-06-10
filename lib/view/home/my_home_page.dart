// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/controller/bloc/tasks_cubit.dart';
import 'package:to_do_app/controller/bloc/tasks_states.dart';
import 'package:to_do_app/model/constants/animated_page-route.dart';

import 'package:to_do_app/model/constants/constants.dart';
import 'package:to_do_app/model/database/local_data_base.dart';
import 'package:to_do_app/model/database/tasks_model.dart';
import 'package:to_do_app/view/add_new_tasks/add_new_tasks.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final dataBase = LocalDataBase.db;
  final _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();

  final timeController = TextEditingController();
  final cateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext ctx, state) {
        final cubit = TasksCubit.get(ctx);
        return LayoutBuilder(
          builder: (context, constrain) {
            return Scaffold(
                key: _key,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: const Color(0xff7646FF),
                  centerTitle: false,
                  title: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: constrain.maxWidth * 0.02),
                    child: Text(
                      cubit.tittles[cubit.currentIndex],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: constrain.maxWidth * 0.06,
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          end: constrain.maxWidth * 0.04),
                      child: IconButton(
                        onPressed: () => onPressed(
                          context: context,
                          beginDx: 10.0,
                          beginDy: -10.0,
                          endDx: 0.0,
                          endDy: 0.0,
                        ),
                        icon: Icon(
                          Icons.add,
                          size: constrain.maxWidth * 0.1,
                        ),
                      ),
                    )
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (cubit.isDone == true) {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        cubit.addTasks(
                          TaskModel(
                            category: cateController.text,
                            date: dateController.text,
                            description: descController.text,
                            taskName: titleController.text,
                            time: timeController.text,
                            status: connew,
                          ),
                          context,
                        );
                        Navigator.pop(context);
                        titleController.clear();
                        descController.clear();
                        dateController.clear();
                        timeController.clear();
                        cateController.clear();
                        cubit.isDonestate(true);
                      }
                    } else {
                      cubit.isDonestate(true);
                      _key.currentState!
                          .showBottomSheet(
                            (context) {
                              return bottomSheet(constrain, context);
                            },
                          )
                          .closed
                          .then((value) {
                            cubit.isDonestate(false);
                            titleController.clear();
                            descController.clear();
                            dateController.clear();
                            timeController.clear();
                            cateController.clear();
                          });
                    }
                  },
                  child: Icon(
                    cubit.isDone ? Icons.done : Icons.add,
                    size: constrain.maxWidth * 0.1,
                  ),
                  backgroundColor: primaryColor,
                  elevation: 0,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: primaryColor,
                  unselectedItemColor: Colors.green,
                  selectedLabelStyle: TextStyle(color: primaryColor),
                  unselectedLabelStyle: TextStyle(color: Colors.green),
                  onTap: (value) {
                    cubit.changeIndex(value);
                  },
                  elevation: 0,
                  currentIndex: cubit.currentIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.menu,
                      ),
                      label: 'Taska',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.task_sharp,
                      ),
                      label: 'Done',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.archive_rounded,
                      ),
                      label: 'Arch',
                    ),
                  ],
                ),
                body: cubit.pages[cubit.currentIndex]);
          },
        );
      },
    );
  }

  Form bottomSheet(BoxConstraints constrain, BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsetsDirectional.only(
          top: constrain.maxHeight * 0.015,
          start: constrain.maxHeight * 0.015,
          end: constrain.maxHeight * 0.015,
          bottom: constrain.maxHeight * 0.015,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // add tak name................................................
            TextFormField(
              autocorrect: false,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Task Name'),
              ),
              controller: titleController,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'please enter a valid tiitle';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                titleController.text = value;
              },
              onSaved: (value) {
                titleController.text = value!;
              },
            ),
            SizedBox(height: constrain.maxHeight * 0.015),
            // Add task description ...........................................
            TextFormField(
              autocorrect: false,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Task Description'),
              ),
              controller: descController,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'please enter a valid description';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                descController.text = value;
              },
              onSaved: (value) {
                descController.text = value!;
              },
            ),
            SizedBox(height: constrain.maxHeight * 0.015),
            // select date ................................................
            TextFormField(
              autocorrect: false,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Task Date'),
              ),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1994),
                  lastDate: DateTime(2100),
                ).then((value) {
                  value == null
                      ? dateController.text =
                          DateFormat('yyyy-MM-dd').format(DateTime.now())
                      : dateController.text =
                          DateFormat('yyyy-MM-dd').format(value);
                });
              },
              keyboardType: TextInputType.number,
              controller: dateController,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'please enter a valid date';
                }
                return null;
              },
              onChanged: (value) {
                dateController.text = value;
              },
              onSaved: (value) {
                dateController.text = value!;
              },
            ),
            SizedBox(height: constrain.maxHeight * 0.015),
            // select  time ......................................
            TextFormField(
              autocorrect: false,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Task Time'),
              ),
              controller: timeController,
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  value == null
                      ? timeController.text = TimeOfDay.now().format(context)
                      : timeController.text = value.format(context);
                });
              },
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'please enter a valid time';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              onChanged: (value) {
                timeController.text = value;
              },
              onSaved: (value) {
                timeController.text = value!;
              },
            ),
            SizedBox(height: constrain.maxHeight * 0.015),
            //select category...........................................
            TextFormField(
              autocorrect: false,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Task Category'),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'please enter a valid category';
                }
                return null;
              },
              controller: cateController,
              onFieldSubmitted: (value) {
                cateController.text = value;
              },
              onSaved: (value) {
                cateController.text = value!;
              },
            ),
          ],
        ),
      ),
    );
  }
}

void onPressed({
  BuildContext? context,
  double? beginDx,
  double? beginDy,
  double? endDx,
  double? endDy,
}) {
  Navigator.push(
    context!,
    AnimatedPageRoute(
      beginDx: beginDx,
      beginDy: beginDy,
      endDx: endDx,
      endDy: endDy,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
      widget: const AddNewTasksScreen(),
    ),
  );
}
