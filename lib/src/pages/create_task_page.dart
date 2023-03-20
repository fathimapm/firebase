import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_firebase_app/src/cubit/tasks/tasks_cubit.dart';
import 'package:my_firebase_app/src/models/task_model.dart';
class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Task"),
          centerTitle: true,
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Title"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _startDateController,
                  onTap: () async {
                    startDate =  await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030));
                    if (startDate != null) {
                      _startDateController.text = startDate.toString();
                    }
                  },
                  decoration: InputDecoration(labelText: "Start Date"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _endDateController,
                  onTap: () async {
                    endDate = await  showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030));
                    if (endDate != null) {
                      _endDateController.text = endDate.toString();
                    }
                  },
                  decoration: InputDecoration(labelText: "End Date"),
                ),
                SizedBox(
                  height: 15,
                ),
                BlocConsumer<TasksCubit, TasksState>(
                  listener: (context, state) {
                    if(state is TasksCreated) {
                      Navigator.pop(context);
                    }else if(state is TasksCreateError){
                      Fluttertoast.showToast(
                          msg: "Error Creating a Task",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if(state is TasksLoading){
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                        onPressed: () {
                          TaskModel taskModel = TaskModel(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              endDate:
                              endDate ?? DateTime.now().add(Duration(days: 5)),
                              startDate: startDate ?? DateTime.now(),
                              isCompleted: false);
                          context.read<TasksCubit>().createTasks(taskModel);
                        },
                        child: Text("Add Task"));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}