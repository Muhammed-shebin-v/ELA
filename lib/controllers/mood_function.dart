

import 'dart:developer';

import 'package:ela/model/mood/mood_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

Future<void> saveMood({ required MoodModel mood}) async {
   final moodBox = await Hive.openBox<MoodModel>('mood');
   String datekey=DateFormat('yyyy-MM-dd').format(mood.date);
    moodBox.put(datekey,mood); 
    MoodModel? _check= await moodBox.get(datekey);
    log(_check!.mood);
  }

  class MoodService {
  Future<Map<DateTime, String>> fetchMoodData() async {
    final moodBox = await Hive.openBox<MoodModel>('mood');
    Map<DateTime, String> moodData = {};

    for (var key in moodBox.keys) {
      final moodModel = moodBox.get(key);
      if (moodModel != null) {
        moodData[moodModel.date] = moodModel.mood;
      }
    }
    return moodData;
  }
}


// Future<Map<String, int>> fetchMoodData(DateTime startDate, DateTime endDate) async {
//   final box = await Hive.openBox<MoodModel>('mood');
//   Map<String, int> moodCounts = {
//     'happy': 0,
//     'sad': 0,
//     'angry': 0,
//     'surprised': 0,
//     'neutral': 0,
//     'disgusted': 0,
//   };

//   for (var moodEntry in box.values) {
//     // Check if the date is within the specified range
//     if (moodEntry.date.isAfter(startDate) && moodEntry.date.isBefore(endDate)) {
//       moodCounts[moodEntry.mood] = (moodCounts[moodEntry.mood] ?? 0) + 1;
//     }
//   }

//   return moodCounts;
// }


Future<Map<DateTime, String>> fetchMoodData(DateTime startDate, DateTime endDate) async {
  final box = await Hive.openBox<MoodModel>('mood');
  Map<DateTime, String> moodData = {};

  for (var moodEntry in box.values) {
    if (moodEntry.date.isAfter(startDate) && moodEntry.date.isBefore(endDate)) {
      moodData[moodEntry.date] = moodEntry.mood;
    }
  }

  return moodData;
}
