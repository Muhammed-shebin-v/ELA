import 'package:ela/model/gaols/water/water_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class WaterIntakeService {
  final Box<WaterModel> _waterIntakeBox = Hive.box<WaterModel>('water');
  String _getDateKey(DateTime date) => '${date.year}-${date.month}-${date.day}';
  Future<WaterModel> _getTodayIntake() async {
    String dateKey = _getDateKey(DateTime.now());
    var intake = _waterIntakeBox.get(dateKey);
    if (intake == null) {
      intake = WaterModel(date: DateTime.now(), intake: 0.0);
      await _waterIntakeBox.put(dateKey, intake);
    }
    return intake;
  }

  Future<void> increaseIntake(double amount) async {
    final intake = await _getTodayIntake();
    intake.intake += amount;
     await _waterIntakeBox.put(_getDateKey(intake.date), intake);
  }


  Future<void> decreaseIntake(double amount) async {
    final intake = await _getTodayIntake();
    intake.intake = (intake.intake - amount).clamp(0, double.infinity);
     await _waterIntakeBox.put(_getDateKey(intake.date), intake); 
  }


  Future<double> getTodayIntakeAmount() async {
    final intake = await _getTodayIntake();
    return intake.intake;
  }

  
}
