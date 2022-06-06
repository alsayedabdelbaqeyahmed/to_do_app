// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:to_do_app/model/constants/constants.dart';
import 'package:to_do_app/model/database/local_data_base.dart';
import 'package:to_do_app/model/database/tasks_model.dart';
import 'package:to_do_app/view/add_new_tasks/default_buttons.dart';
import 'package:to_do_app/view/add_new_tasks/select_category.dart';

import 'package:intl/intl.dart';
import 'package:to_do_app/view/home/my_home_page.dart';

import '../../model/constants/animated_page-route.dart';

class AddNewTaskForm extends StatefulWidget {
  final BoxConstraints? constr;
  const AddNewTaskForm({Key? key, this.constr}) : super(key: key);

  @override
  State<AddNewTaskForm> createState() => _AddNewTaskFormState();
}

class _AddNewTaskFormState extends State<AddNewTaskForm> {
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
                start: widget.constr!.maxWidth * 0.02,
                end: widget.constr!.maxWidth * 0.02,
                top: widget.constr!.maxHeight * 0.01,
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
                  SizedBox(height: widget.constr!.maxHeight * 0.05),

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
                  SizedBox(height: widget.constr!.maxHeight * 0.05),

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
                              ? setState(() {
                                  taskDate = formatter.format(date);
                                })
                              : taskDate = formatter.format(DateTime.now());
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
                              context: context, initialTime: selectTime!);
                          date != null
                              ? setState(() {
                                  taskTime = date.format(context);
                                  selectTime = date;
                                })
                              : taskTime =
                                  selectTime!.format(context).toString();
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
                          setState(
                            () {
                              categoryValue = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: widget.constr!.maxHeight * 0.05),
                  categoryValue!.trim() == 'Other'
                      ? TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            label: Text('Task Category'),
                          ),
                          validator: (value) {
                            if (value!.trim() == null || value.trim().isEmpty) {
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
                final db = LocalDataBase.db;
                db
                    .insertData(
                      TaskModel(
                          category: categoryValue,
                          taskName: taskName,
                          date: taskDate,
                          description: taskDescription,
                          time: taskTime),
                    )
                    .then(
                      (value) => Navigator.pushReplacement(
                        context,
                        AnimatedPageRoute(
                          beginDx: 10.0,
                          beginDy: 10.0,
                          endDx: 0.0,
                          endDy: 0.0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.ease,
                          widget: const MyHomePage(),
                        ),
                      ),
                    );
              },
              buttoncolors: primaryColor,
              textcolors: Colors.white,
              size: widget.constr!,
            )
          ],
        ),
      ),
    );
  }
}
