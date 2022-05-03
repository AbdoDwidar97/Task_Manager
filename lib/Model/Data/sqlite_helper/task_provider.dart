import 'package:sqflite/sqflite.dart';
import 'package:task_manager/Model/Components/task_table.dart';
import 'package:task_manager/Model/Data/sqlite_helper/db_configuration.dart';

class TaskProvider
{
  Future<TaskTable> insert(TaskTable table) async
  {
    Database myDatabase = await DBConfiguration().db;
    table.id = await myDatabase.insert(table.table_name, table.toMap());
    return table;
  }

  Future<List<TaskTable>> getAllTasks() async
  {
    Database myDatabase = await DBConfiguration().db;
    List<TaskTable> tasks = [];

    List<Map<String, dynamic>> list = await myDatabase.rawQuery('SELECT * FROM ${TaskTable().table_name}');
    for (var element in list) {
      tasks.add(TaskTable.fromMap(element));
    }

    return tasks;
  }

  Future<TaskTable?> getTask(int id) async
  {
    Database myDatabase = await DBConfiguration().db;

    TaskTable taskTable = TaskTable();
    List<Map<String, dynamic>> maps = await myDatabase.query(taskTable.table_name,
        columns: [
          taskTable.id_column,
          taskTable.taskName_column,
          taskTable.description_column,
          taskTable.dateFrom_column,
          taskTable.dateTo_column,
          taskTable.taskStatus_id_column
        ],
        where: '${taskTable.id_column} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty)
    {
      return TaskTable.fromMap(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async
  {
    Database myDatabase = await DBConfiguration().db;

    TaskTable taskTable = TaskTable();
    return await myDatabase
        .delete(taskTable.table_name, where: '${taskTable.id_column} = ?', whereArgs: [id]);
  }

  Future<int> update(TaskTable table) async
  {
    Database myDatabase = await DBConfiguration().db;

    return await myDatabase.update(table.table_name, table.toMap(),
        where: '${table.id_column} = ?', whereArgs: [table.id]);
  }

}