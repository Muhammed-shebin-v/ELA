import 'dart:developer';
import 'package:ela/controllers/water_goal_function.dart';
import 'package:ela/view/theme/app_color.dart';
import 'widget/dialygoals.dart';
import 'widget/heading.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  final WaterIntakeService waterService = WaterIntakeService();
  double currentIntake = 0.0;
  final double dailyGoal = 2000.0;

  @override
  void initState() {
    super.initState();
    loadCurrentIntake();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ElaColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Gap(20),
                const CustomHeading(
                  heading: 'Dialy Goals',
                  length: 165,
                ),
                const Gap(20),
   



                 CustomDialyGoals(
                  increasefunction:increaseIntake,
                  decreasefunction: decreaseIntake,
                  currentIntake: currentIntake,
                  dialyGoal: dailyGoal,
                    goalindex: 1,
                    title: 'water',
                    titlelength: 60,
                    subtitle:
                        '"Drink at least 8 liters of water daily.Aim for 10 liters to reach your hydration goal!"',
                    count: '9Ltr'),
                const Gap(20),
                // const CustomDialyGoals(
                //     goalindex: 2,
                //     titlelength: 60,
                //     title: 'Sleep',
                //     subtitle:
                //         '"Aim for at least 6 hours of sleep each night. Strive for 8 hours to truly recharge and thrive!"',
                //     count: '4Hrs'),
                // const Gap(20),
                // const CustomDialyGoals(
                //     goalindex: 3,
                //     titlelength: 55,
                //     title: 'Walk',
                //     subtitle:
                //         '"Walk at least 4,000 steps daily. Aim for 5,000 to reach your goal!"',
                //     count: '3500 Stps'),
                // const Gap(20),
                // const CustomDialyGoals(
                //     goalindex: 4,
                //     titlelength: 55,
                //     title: 'Read',
                //     subtitle:
                //         '"Read at least 20 pages daily. Aim for 30 to hit your goal!"',
                //     count: '10Pgs'),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> loadCurrentIntake() async {
    final intake = await waterService.getTodayIntakeAmount();
    log('loaded data');
    setState(() {
      currentIntake = intake;
    });
  }

  void increaseIntake() async {
    if (currentIntake + 250.0 <= dailyGoal) { 
      await waterService.increaseIntake(250.0);
      loadCurrentIntake();
    } else {
   
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You've reached your daily goal!")),
      );
    }
  }
     void decreaseIntake() async {
    if (currentIntake - 250.0 >= 0) { 
      await waterService.decreaseIntake(250.0);
      loadCurrentIntake();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Intake cannot go below zero.")),
      );
    }
  }

  
}
