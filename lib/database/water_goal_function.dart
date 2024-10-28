  
  




import 'package:ela/model/water/water_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

Future<void> saveMood({ required WaterModel water}) async {
   final moodBox = await Hive.openBox<WaterModel>('water');
   String datekey=DateFormat('yyyy-MM-dd').format(water.date);
    moodBox.put(datekey,water); 
  }