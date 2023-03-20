part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {
  const TasksState();
}

class TasksInitial extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksLoading extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksLoaded extends TasksState {
  final List<TaskModel> taskList;

   const TasksLoaded(this.taskList);

  @override
  List<Object> get props => [taskList];
}
class TasksLoadError extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksUpdating extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksUpdated extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksUpdateError extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksCreating extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksCreated extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksCreateError extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksDeleting extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksDeleted extends TasksState {
  final TaskModel taskModel;
  TasksDeleted(this.taskModel);
  @override
  List<Object> get props => [taskModel];
}
class TasksDeleteError extends TasksState {
  @override
  List<Object> get props => [];
}