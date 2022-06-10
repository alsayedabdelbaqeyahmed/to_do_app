import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:to_do_app/controller/bloc/tasks_cubit.dart';
import 'package:to_do_app/controller/bloc/tasks_states.dart';
import 'package:to_do_app/model/constants/animated_page-route.dart';

import 'package:to_do_app/model/constants/tasks.dart';
import 'package:to_do_app/view/add_new_tasks/add_new_tasks.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext ctx, state) {
        final cubit = TasksCubit.get(ctx);
        return Tasks(tasks: cubit.newTasks);
      },
    );
  }
}
