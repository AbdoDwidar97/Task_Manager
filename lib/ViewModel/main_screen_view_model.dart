import 'package:flutter/material.dart';
import 'package:task_manager/Model/Components/task.dart';

class MainScreenViewModel with ChangeNotifier
{
  final List<Task> _tasks = [

    Task(
      taskName: "Task 1",
      description: "Better job descriptions attract better candidates. Optimized for job board approval and SEO, our 700+ job description templates boost exposure, provide inspiration and speed up hiring. Rich in the right kind of content, they also lead to more qualified applicants.",
      dateFrom: DateTime.now(),
      dateTo: DateTime.now().add(const Duration(days: 3)),
      taskStatus: 0,
      tags: [
        "CRM",
        "Dynamics 365"
      ]
    ),

    Task(
        taskName: "Task 2",
        description: "Better job descriptions attract better candidates. Optimized for job board approval and SEO, our 700+ job description templates boost exposure, provide inspiration and speed up hiring. Rich in the right kind of content, they also lead to more qualified applicants.",
        dateFrom: DateTime.now(),
        dateTo: DateTime.now().add(const Duration(days: 3)),
        taskStatus: 0,
        tags: [
          "Flutter",
          "API"
        ]
    ),

    Task(
        taskName: "Task 3",
        description: "Better job descriptions attract better candidates. Optimized for job board approval and SEO, our 700+ job description templates boost exposure, provide inspiration and speed up hiring. Rich in the right kind of content, they also lead to more qualified applicants.",
        dateFrom: DateTime.now(),
        dateTo: DateTime.now().add(const Duration(days: 3)),
        taskStatus: 0,
        tags: [
          "UI/UX Design",
          "Figma"
        ]
    ),

  ];

  List <Task> get tasks => _tasks;
}