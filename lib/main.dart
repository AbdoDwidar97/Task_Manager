import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/View/main_screen.dart';
import 'package:task_manager/ViewModel/create_task_screen_view_model.dart';
import 'package:task_manager/ViewModel/main_screen_view_model.dart';

void main()
{
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MainScreenViewModel()),
      ChangeNotifierProvider(create: (_) => CreateTaskScreenViewModel()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    ),
  ));
}
