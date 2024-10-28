import 'package:ela/theme/app_textstyle.dart';
import '../widget/dialygoals.dart';
import '../widget/heading.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Gap(65),
              CustomHeading(
                  heading: 'Dialy Goals',
                  length: 165,
                 ),
              Gap(20),
              CustomDialyGoals(
                goalindex: 1,
                  title: 'water',
                  titlelength:60 ,
                  subtitle:
                      '"Drink at least 8 liters of water daily.Aim for 10 liters to reach your hydration goal!"',
                  count: '9Ltr'),
              Gap(20),
              CustomDialyGoals(
                goalindex: 2,
                titlelength: 60,
                  title: 'Sleep',
                  subtitle:
                      '"Aim for at least 6 hours of sleep each night. Strive for 8 hours to truly recharge and thrive!"',
                  count: '4Hrs'),
              Gap(20),
              CustomDialyGoals(
                goalindex: 3,
                titlelength: 55,
                  title: 'Walk',
                  subtitle:
                      '"Walk at least 4,000 steps daily. Aim for 5,000 to reach your goal!"',
                  count: '3500 Stps'),
              Gap(20),
              CustomDialyGoals(
                goalindex: 4,
                titlelength: 55,
                  title: 'Read',
                  subtitle:
                      '"Read at least 20 pages daily. Aim for 30 to hit your goal!"',
                  count: '10Pgs'),
            ],
          ),
        ),
      ),
    );
  }
}
