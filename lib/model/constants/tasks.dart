import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/controller/bloc/tasks_cubit.dart';
import 'package:to_do_app/controller/bloc/tasks_states.dart';
import 'package:to_do_app/model/constants/animated_page-route.dart';

import 'package:to_do_app/model/constants/constants.dart';
import 'package:to_do_app/view/add_new_tasks/add_new_tasks.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key, required this.tasks}) : super(key: key);
  final List<Map<String, dynamic>>? tasks;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => LayoutBuilder(
        builder: (ctx, size) {
          final cubit = TasksCubit.get(ctx);
          //print(cubit.tasks);

          return tasks!.isEmpty
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
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return tasks![index][condate] ==
                            DateFormat('yyyy-MM-dd').format(DateTime.now())
                        ? Dismissible(
                            background: Container(
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            key: UniqueKey(),
                            onDismissed: (diss) {
                              cubit.deletetask(tasks![index]['id'], context);
                            },
                            child: InkWell(
                              onTap: () {
                                print(tasks![index]);
                                Navigator.push(
                                  context,
                                  AnimatedPageRoute(
                                    beginDx: 10,
                                    beginDy: 10,
                                    endDx: 0,
                                    endDy: 0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.ease,
                                    widget: AddNewTasksScreen(
                                      tasks: tasks![index],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: size.maxWidth * .02,
                                    bottom: size.maxWidth * .02,
                                    top: size.maxWidth * .02,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: size.maxWidth * 0.05,
                                            backgroundColor: Colors.transparent,
                                            child: Text(
                                              tasks![index][contime],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.maxWidth * 0.04,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: size.maxWidth * 0.05),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                tasks![index][conname],
                                                style: TextStyle(
                                                  fontSize:
                                                      size.maxWidth * 0.06,
                                                ),
                                              ),
                                              Text(
                                                tasks![index][concateg],
                                                style: TextStyle(
                                                  fontSize:
                                                      size.maxWidth * 0.05,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              cubit.updateTaskStatus(condone,
                                                  tasks![index]['id'], context);
                                            },
                                            icon: const Icon(
                                              Icons.done_rounded,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              cubit.updateTaskStatus(
                                                  conarchived,
                                                  tasks![index]['id'],
                                                  context);
                                            },
                                            icon: const Icon(
                                              Icons.archive_rounded,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                  separatorBuilder: (ctx, number) {
                    return Container(
                      width: double.infinity,
                      height: 1,
                      color: primaryColor.withOpacity(.2),
                    );
                  },
                  itemCount: tasks!.length,
                );
        },
      ),
    );
  }
}
