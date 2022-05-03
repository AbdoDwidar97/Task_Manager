import 'package:task_manager/Model/Components/task.dart';

class TaskTable
{
  String? taskName, description;
  DateTime? dateFrom, dateTo;
  int? id, taskStatus;

  TaskTable({
    this.id,
    this.taskName,
    this.taskStatus,
    this.description,
    this.dateFrom,
    this.dateTo,
  });

  Map<String, dynamic> toMap()
  {
    var map = <String, dynamic>{
      taskName_column: taskName,
      description_column: description_column,
      dateFrom_column: dateFrom,
      dateTo_column: dateTo,
      taskStatus_id_column: taskStatus
    };

    if (id != null) {
      map[id_column] = id;
    }

    return map;
  }

  TaskTable.fromMap(Map<String, dynamic> map)
  {
    id = int.parse(map[id_column].toString());
    taskName = map[taskName_column].toString();
    description = map[description_column].toString();
    dateFrom = DateTime.parse(map[dateFrom_column].toString());
    dateTo = DateTime.parse(map[dateTo_column].toString());
    taskStatus = int.parse(map[taskName_column].toString());
  }

}

extension TaskTableExtension on TaskTable
{
  String get table_name => "task";
  String get id_column => "id";
  String get taskName_column => "task_name";
  String get description_column => "description";
  String get dateFrom_column => "date_time_from";
  String get dateTo_column => "date_to_from";
  String get taskStatus_id_column => "task_status_id";

  Task parseToTask()
  {
    Task parsedTask = Task(
      id: id,
      taskName: taskName,
      description: description,
      taskStatus: taskStatus,
      dateFrom: dateFrom,
      dateTo: dateTo,
      tags: []
    );

    return parsedTask;
  }

}