class TagTable
{
  int? id, taskID;
  String? tagName;

  TagTable({
    this.id,
    this.taskID,
    this.tagName
  });

  Map<String, dynamic> toMap()
  {
    var map = <String, dynamic>{
      tagName_column: tagName,
      task_id_column: taskID
    };

    if (id != null) {
      map[id_column] = id;
    }

    return map;
  }

  TagTable.fromMap(Map<String, dynamic> map)
  {
    id = int.parse(map[id_column].toString());
    tagName = map[tagName_column].toString();
    taskID = int.parse(map[task_id_column].toString());
  }

}

extension TagTableExtension on TagTable
{
  String get table_name => "tag";
  String get id_column => "id";
  String get tagName_column => "tag_name";
  String get task_id_column => "task_id";
}