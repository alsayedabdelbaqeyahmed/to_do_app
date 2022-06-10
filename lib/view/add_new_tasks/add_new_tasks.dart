import 'package:flutter/material.dart';
import 'package:to_do_app/model/constants/animated_page-route.dart';
import 'package:to_do_app/model/constants/constants.dart';
import 'package:to_do_app/view/add_new_tasks/add_new_task_form.dart';

class AddNewTasksScreen extends StatelessWidget {
  final Map<String, dynamic>? tasks;
  const AddNewTasksScreen({Key? key, this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Padding(
              padding:
                  EdgeInsetsDirectional.only(start: constrain.maxWidth * 0.02),
              child: Text(
                'NewTask',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: constrain.maxWidth * 0.06,
                ),
              ),
            ),
            centerTitle: false,
            actions: [
              Padding(
                padding:
                    EdgeInsetsDirectional.only(end: constrain.maxWidth * 0.04),
                child: IconButton(
                  onPressed: () => Navigator.pop(
                    context,
                    AnimatedPageRoute(
                      beginDx: -10.0,
                      beginDy: 0,
                      endDx: 10.0,
                      endDy: 0.0,
                      duration: const Duration(seconds: 2),
                      curve: Curves.ease,
                      widget: const AddNewTasksScreen(),
                    ),
                  ),
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: constrain.maxWidth * 0.1,
                  ),
                ),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: AddNewTaskForm(
                  constr: constrain,
                  tasks: tasks,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
