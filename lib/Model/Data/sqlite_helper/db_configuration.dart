import 'package:sqflite/sqflite.dart';
import 'package:task_manager/Model/Components/tag_table.dart';
import 'package:task_manager/Model/Components/task_table.dart';

class DBConfiguration
{
  static DBConfiguration? _instance;
  DBConfiguration._internal();

  Database? _db;

  factory DBConfiguration()
  {
    _instance ??= DBConfiguration._internal();

    return _instance!;
  }

  Future<Database> get db async
  {
    if (_db == null)
    {
      await open("TaskManagerDB.db");
    }

    return _db!;
  }

  Future open(String path) async
  {
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async
        {
          TaskTable taskTable = TaskTable();
          await db.execute('''
          create table ${taskTable.table_name} (
            ${taskTable.id_column} integer primary key autoincrement,
            ${taskTable.taskName_column} text not null,
            ${taskTable.description_column} text not null,
            ${taskTable.dateFrom_column} text not null,
            ${taskTable.dateTo_column} text not null,
            ${taskTable.taskStatus_id_column} integer not null)
          ''');

          TagTable tagTable = TagTable();
          await db.execute('''
          create table ${tagTable.table_name} (
            ${tagTable.id_column} integer primary key autoincrement, 
            ${tagTable.tagName_column} text not null)
          ''');
        });
  }

  Future close() async => _db!.close();
}