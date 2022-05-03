class Task
{
  String? taskName, description;
  List<String>? tags;
  DateTime? dateFrom, dateTo;
  int? id, taskStatus;

  Task({
    this.id,
    this.taskName,
    this.taskStatus,
    this.description,
    this.tags,
    this.dateFrom,
    this.dateTo,
  });

}