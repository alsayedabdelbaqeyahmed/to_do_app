import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/controller/bloc/tasks_cubit.dart';
import 'package:to_do_app/controller/bloc/tasks_states.dart';

import 'package:to_do_app/model/constants/constants.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => LayoutBuilder(
        builder: (ctx, size) {
          final cubit = TasksCubit.get(ctx);
          print(cubit.doneTasks);
          return cubit.doneTasks.isEmpty
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
                    return Dismissible(
                      key: Key(cubit.doneTasks[index]['id'].toString()),
                      onDismissed: (diss) {
                        cubit.deletetask(cubit.doneTasks[index]['id'], context);
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: size.maxWidth * .02,
                          bottom: size.maxWidth * .02,
                          top: size.maxWidth * .02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  cubit.doneTasks[index][contime],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  cubit.doneTasks[index][condate],
                                  style: const TextStyle(
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.maxWidth * .04),
                            Column(
                              children: [
                                Text(
                                  cubit.doneTasks[index][conname],
                                  style: TextStyle(
                                      fontSize: size.maxWidth * 0.1,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  cubit.doneTasks[index][condesc],
                                  style: TextStyle(
                                      fontSize: size.maxWidth * 0.05,
                                      color: primaryColor),
                                ),
                              ],
                            ),
                            Text(cubit.doneTasks[index][concateg]),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, number) {
                    return Container(
                      width: double.infinity,
                      height: 1,
                      color: primaryColor,
                    );
                  },
                  itemCount: cubit.doneTasks.length,
                );
        },
      ),
    );
  }
}
