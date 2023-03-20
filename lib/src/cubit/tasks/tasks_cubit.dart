import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:my_firebase_app/src/cubit/tasks/tasks_repository.dart';
import 'package:my_firebase_app/src/models/task_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksRepository _repository =TasksRepository();
  TasksCubit() : super(TasksInitial());

  createTasks(TaskModel taskModel)async{
    emit(TasksCreating());
    try{
      await _repository.createTasks(taskModel);
      emit(TasksCreated());
      await Future.delayed(Duration(seconds: 1));
      getAllTasks();
    }catch(ex){
      emit(TasksCreateError());
    }
  }
  updateTasks(TaskModel updatedTask)async{
    emit(TasksUpdating());
    try{
      await _repository.updateTasks(updatedTask);
      emit(TasksUpdated());
      await Future.delayed(Duration(seconds: 1));

      getAllTasks();
    }catch(ex){
      emit(TasksUpdateError());
    }
  }
  deleteTasks(TaskModel taskModel)async{
    emit(TasksDeleting());
    try{
      await _repository.deleteTasks(taskModel);
      emit(TasksDeleted(taskModel));
      await Future.delayed(Duration(seconds: 1));
      getAllTasks();
    }catch(ex){
      emit(TasksUpdateError());
    }
  }

  getAllTasks()async{
    emit(TasksLoading());
    try{
QuerySnapshot snapshot = await _repository.getAllTasks();

 List<TaskModel> taskList =snapshot.docs.map<TaskModel>((e) {
  Map<String, dynamic>  dx = e.data() as Map<String, dynamic>;
  String id =e.id;
 TaskModel taskModel = TaskModel.fromJson(dx);
 taskModel.id =id;
 return taskModel;
}).toList();
emit(TasksLoaded(taskList));

    }catch(ex){
emit(TasksLoadError());
    }
  }
}
