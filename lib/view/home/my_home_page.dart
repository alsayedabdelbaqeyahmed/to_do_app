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
import 'package:to_do_app/view/add_new_tasks/select_category.dart';
import 'package:to_do_app/view/home/floating_action.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final dataBase = LocalDataBase.db;
  final _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                floatingActionButton: FloatingAction(
                  constrains: constrain,
                  scaffoldkey: _key,
                  formKey: _formKey,
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
                        Icons.delete,
                      ),
                      label: 'Bin',
                    ),
                  ],
                ),
                body: cubit.pages[cubit.currentIndex]);
          },
        );
      },
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
