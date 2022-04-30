enum TaskStatus
{
  open,
  closed,
  inProgress,
  canceled
}

extension TaskExtension on TaskStatus
{

  String getString()
  {
    switch(this)
    {
      case TaskStatus.open:
        return "Open";
      case TaskStatus.closed:
        return "Closed";
      case TaskStatus.inProgress:
        return "In Progress";
      case TaskStatus.canceled:
        return "Canceled";
    }
  }

}