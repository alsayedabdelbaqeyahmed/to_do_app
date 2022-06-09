// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/controller/bloc/tasks_cubit.dart';
import 'package:to_do_app/controller/bloc/tasks_states.dart';
import 'package:to_do_app/model/constants/constants.dart';
import 'package:to_do_app/model/database/local_data_base.dart';
import 'package:to_do_app/model/database/tasks_model.dart';
import 'package:to_do_app/view/add_new_tasks/default_buttons.dart';
import 'package:to_do_app/view/add_new_tasks/select_category.dart';

import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AddNewTaskForm extends StatelessWidget {
  AddNewTaskForm({Key? key, this.constr}) : super(key: key);

  final BoxConstraints? constr;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final focus = FocusNode();

  String? taskName;
  String? taskDescription;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String? taskDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TimeOfDay? selectTime = TimeOfDay.now();
  String? taskTime = '';

  String? categoryValue = 'Work';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext ctx, state) {
          final cubit = TasksCubit.get(ctx);
          return InkWell(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // first column to applu padding at formfield only without buttons...........
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: constr!.maxWidth * 0.02,
                      end: constr!.maxWidth * 0.02,
                      top: constr!.maxHeight * 0.01,
                    ),
                    child: Column(
                      children: [
                        // add tak name................................................
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            label: Text('Task Name'),
                          ),
                          autofocus: true,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus);
                          },
                          validator: (value) {
                            if (value!.trim() == null || value.trim().isEmpty) {
                              return 'please enter the Task Name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            taskName = value;
                          },
                          onSaved: (value) {
                            taskName = value;
                          },
                        ),
                        SizedBox(height: constr!.maxHeight * 0.05),

                        // Add task description ...........................................
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          focusNode: focus,
                          maxLines: null,
                          decoration: const InputDecoration(
                            label: Text('Description'),
                          ),
                          validator: (value) {
                            if (value!.trim() == null || value.trim().isEmpty) {
                              return 'please enter the Task Name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            taskDescription = value;
                          },
                          onSaved: (value) {
                            taskDescription = value;
                          },
                        ),
                        SizedBox(height: constr!.maxHeight * 0.05),

                        // select date ................................................
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final DateTime? initialDate =
                                    DateTime.parse(taskDate!);
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: initialDate!,
                                  firstDate: DateTime(1994),
                                  lastDate: DateTime(2100),
                                );
                                date != null
                                    ? taskDate = formatter.format(date)
                                    : taskDate =
                                        formatter.format(DateTime.now());
                              },
                              child: Text(
                                taskDate!,
                                style: const TextStyle(color: primaryColor),
                              ),
                            ),

                            // select  time ......................................
                            TextButton(
                              onPressed: () async {
                                final date = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                date != null
                                    ? taskTime = date.format(context)
                                    : taskTime = TimeOfDay.now()
                                        .format(context)
                                        .toString();
                              },
                              child: Text(
                                taskTime!.trim().isEmpty || taskTime == null
                                    ? selectTime!.format(context)
                                    : taskTime!,
                                style: const TextStyle(color: primaryColor),
                              ),
                            ),
                            //select category...........................................
                            SelectCategory(
                              value: categoryValue,
                              onChanged: (value) {
                                categoryValue = value;
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: constr!.maxHeight * 0.05),
                        categoryValue!.trim() == 'Other'
                            ? TextFormField(
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  label: Text('Task Category'),
                                ),
                                validator: (value) {
                                  if (value!.trim() == null ||
                                      value.trim().isEmpty) {
                                    return 'please enter the Task Category';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  categoryValue = value;
                                },
                                onSaved: (value) {
                                  categoryValue = value;
                                },
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),

                  //add tasks buttons...............................................
                  DefaultButton(
                    text: 'Add',
                    press: () async {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        cubit.addTasks(
                          TaskModel(
                            category: categoryValue,
                            taskName: taskName,
                            date: taskDate,
                            description: taskDescription,
                            time: taskTime,
                          ),
                          context,
                        );
                      }
                    },
                    buttoncolors: primaryColor,
                    textcolors: Colors.white,
                    size: constr!,
                  )
                ],
              ),
            ),
          );
        });
  }
}
