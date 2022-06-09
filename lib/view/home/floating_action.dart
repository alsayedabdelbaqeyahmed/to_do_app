import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/controller/bloc/tasks_cubit.dart';
import 'package:to_do_app/controller/bloc/tasks_states.dart';
import 'package:to_do_app/model/constants/constants.dart';
import 'package:to_do_app/model/database/tasks_model.dart';

class FloatingAction extends StatelessWidget {
  FloatingAction({Key? key, this.constrains, this.scaffoldkey, this.formKey})
      : super(key: key);
  final BoxConstraints? constrains;
  final GlobalKey<ScaffoldState>? scaffoldkey;
  final GlobalKey<FormState>? formKey;
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
        return FloatingActionButton(
          onPressed: () {
            if (cubit.isDone == true) {
              if (formKey!.currentState!.validate()) {
                formKey!.currentState!.save();
                cubit.addTasks(
                  TaskModel(
                    category: cateController.text,
                    date: dateController.text,
                    description: descController.text,
                    taskName: titleController.text,
                    time: timeController.text,
                  ),
                  context,
                );
                cubit.isDonestate(true);
              }
            } else {
              cubit.isDonestate(true);
              scaffoldkey!.currentState!
                  .showBottomSheet(
                    (context) {
                      return bottomSheet(constrains!, context);
                    },
                  )
                  .closed
                  .then((value) {
                    cubit.isDonestate(false);
                  });
            }
          },
          child: Icon(
            cubit.isDone ? Icons.done : Icons.add,
            size: constrains!.maxWidth * 0.1,
          ),
          backgroundColor: primaryColor,
          elevation: 0,
        );
      },
    );
  }

  Form bottomSheet(BoxConstraints constrain, BuildContext context) {
    return Form(
      key: formKey,
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
