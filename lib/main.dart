import 'package:ela/model/bucket/bucket_model.dart';
import 'package:ela/model/diary/diary_model.dart';
import 'package:ela/model/mood/mood_model.dart';
import 'package:ela/model/todo/todo_model.dart';
import 'package:ela/view/create_acount.dart';
import 'package:ela/view/intro.dart';
import 'package:ela/view/splash.dart';
import 'package:ela/view/widget/notchbar.dart';
import 'model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(UserAdapter().typeId)){
    Hive.registerAdapter(UserAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(TodoModelAdapter());
  }
  if(!Hive.isAdapterRegistered(BucketModelAdapter().typeId)){
    Hive.registerAdapter(BucketModelAdapter());
  }
  if(!Hive.isAdapterRegistered(DiaryModelAdapter().typeId)){
    Hive.registerAdapter(DiaryModelAdapter());
  }
  if(!Hive.isAdapterRegistered(MoodModelAdapter().typeId)){
    Hive.registerAdapter(MoodModelAdapter());
  }
  runApp(const Ela());

}

class Ela extends StatelessWidget {
  const Ela ({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    const MaterialApp(
      home: SplashScreen()
      
    );
  }
}