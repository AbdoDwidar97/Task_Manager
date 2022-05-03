import 'package:sqflite/sqflite.dart';
import 'package:task_manager/Model/Components/tag_table.dart';
import 'package:task_manager/Model/Data/sqlite_helper/db_configuration.dart';

class TagProvider
{
  Future<List<TagTable>> getAllTags() async
  {
    Database myDatabase = await DBConfiguration().db;
    List<TagTable> tags = [];

    List<Map<String, dynamic>> list = await myDatabase.rawQuery('SELECT * FROM ${TagTable().table_name}');
    for (var element in list) {
      tags.add(TagTable.fromMap(element));
    }

    return tags;
  }

  Future<TagTable> insert(TagTable table) async
  {
    Database myDatabase = await DBConfiguration().db;

    table.id = await myDatabase.insert(table.table_name, table.toMap());
    return table;
  }

  Future<List<TagTable>> getTagsOfTask(int taskID) async
  {
    Database myDatabase = await DBConfiguration().db;

    TagTable tagTable = TagTable();

    List<TagTable> myTags = [];

    List<Map<String, dynamic>> maps = await myDatabase.query(tagTable.table_name,
        columns: [
          tagTable.id_column,
          tagTable.task_id_column,
          tagTable.tagName_column
        ],
        where: '${tagTable.task_id_column} = ?',
        whereArgs: [taskID]);

    if (maps.isNotEmpty)
    {
      for (var tag in maps)
      {
        myTags.add(TagTable.fromMap(tag));
      }
    }

    return myTags;
  }

  Future<TagTable?> getTag(int id) async
  {
    Database myDatabase = await DBConfiguration().db;

    TagTable tagTable = TagTable();
    List<Map<String, dynamic>> maps = await myDatabase.query(tagTable.table_name,
        columns: [
          tagTable.id_column,
          tagTable.tagName_column
        ],
        where: '${tagTable.id_column} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty)
    {
      return TagTable.fromMap(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async
  {
    Database myDatabase = await DBConfiguration().db;

    TagTable tagTable = TagTable();
    return await myDatabase
        .delete(tagTable.table_name, where: '${tagTable.id_column} = ?', whereArgs: [id]);
  }

  Future<int> update(TagTable table) async
  {
    Database myDatabase = await DBConfiguration().db;

    return await myDatabase.update(table.table_name, table.toMap(),
        where: '${table.id_column} = ?', whereArgs: [table.id]);
  }

}