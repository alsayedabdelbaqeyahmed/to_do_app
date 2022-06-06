// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_app/model/constants/animated_page-route.dart';
import 'package:to_do_app/model/constants/constants.dart';
import 'package:to_do_app/model/database/local_data_base.dart';
import 'package:to_do_app/view/add_new_tasks/add_new_tasks.dart';
import 'package:to_do_app/view/deleted/deleted.dart';
import 'package:to_do_app/view/done/done.dart';
import 'package:to_do_app/view/tasks/tasks.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int index = 0;
List<Widget> pages = [Tasks(), Done(), Deleted()];
List<String> tittles = [
  'Tasks',
  'Done',
  'Deleted',
];
var dataBase = LocalDataBase.db;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    dataBase.initDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff7646FF),
          centerTitle: false,
          title: Padding(
            padding:
                EdgeInsetsDirectional.only(start: constrain.maxWidth * 0.02),
            child: Text(
              tittles[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: constrain.maxWidth * 0.06,
              ),
            ),
          ),
          actions: [
            Padding(
              padding:
                  EdgeInsetsDirectional.only(end: constrain.maxWidth * 0.04),
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
          onPressed: () => onPressed(
            context: context,
            beginDx: 10.0,
            beginDy: 10.0,
            endDx: 0.0,
            endDy: 0.0,
          ),
          child: Icon(
            Icons.add,
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
            setState(() {
              index = value;
            });
          },
          elevation: 0,
          currentIndex: index,
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
        body: pages[index],
      );
    });
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
}
