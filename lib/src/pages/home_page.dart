import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_firebase_app/src/cubit/tasks/tasks_cubit.dart';
import 'package:my_firebase_app/src/models/task_model.dart';
import 'package:my_firebase_app/src/pages/create_task_page.dart';

import 'edit_task_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit()..getAllTasks(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CreateTaskPage()))
                .then((value) {
              context.read<TasksCubit>().getAllTasks();
            });
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              if (state is TasksLoading) {
                return CircularProgressIndicator();
              } else if (state is TasksLoaded) {
                return _buildTaskUI(state.taskList);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  _buildTaskUI(List<TaskModel> taskList) {
    return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          TaskModel item = taskList[index];
          return Card(
            elevation: 10,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title),
                  Text(item.description),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("StartDate:${item.startDate.toString()}"),
                  Text("EndDate:${item.endDate.toString()}"),
                  Text("isCompleted:${item.isCompleted.toString()}")
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditTaskPage(taskModel: item)));
                  }, icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        context.read<TasksCubit>().deleteTasks(item);
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
              
            ),
          );
        });
  }
}