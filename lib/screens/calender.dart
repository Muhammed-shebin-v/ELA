import 'package:ela/database/diary_function.dart';
import 'package:ela/model/diary/diary_model.dart';
import 'package:ela/theme/app_color.dart';
import 'package:ela/theme/app_textstyle.dart';
import 'package:ela/widget/snackbar.dart';
import 'package:intl/intl.dart';
import 'diary.dart';
import '../widget/container.dart';
import '../widget/heading.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Calender> {
  DateTime _selectedDate = DateTime.now();
  DiaryModel? _diaryEntries;

  @override
  void initState() {
    super.initState();
    _loadDiaryEntries();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = focusedDay;
      _loadDiaryEntries();
    });
  }

  void _loadDiaryEntries() async {
    final diaryEntry = await fetchDiary(date: _selectedDate);
    setState(() {
      _diaryEntries = diaryEntry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Gap(40),
            const CustomHeading(
              heading: 'Calender',
              length: 135,
            ),
            const Gap(20),
            CustomContainer(
                boxshadow: true,
                height: 520,
                child: Column(
                  children: [
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 20),
                          child: Text(
                            DateFormat('d').format(_selectedDate),
                            style: const TextStyle(
                                fontSize: 70, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 20),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('MMMM').format(_selectedDate),
                                style: ElaTextStyle.heading,
                              ),
                              Text(
                                DateFormat('y').format(_selectedDate),
                                style: ElaTextStyle.heading,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    TableCalendar(
                        firstDay: DateTime.utc(2020, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _selectedDate,
                        selectedDayPredicate: (day) =>
                        isSameDay(day, _selectedDate),
                        onDaySelected: _onDaySelected,
                        calendarFormat: CalendarFormat.month,
                        availableCalendarFormats: const {
                          CalendarFormat.month: '',
                        },
                        headerStyle: const HeaderStyle(),
                        calendarStyle: const CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            color: ElaColors.green,
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: TextStyle(
                            color: ElaColors.black,
                          ),
                          todayTextStyle: TextStyle(
                            color: ElaColors.black, 
                          ),
                          todayDecoration: BoxDecoration(
                            color:ElaColors.lightgreen, 
                            shape: BoxShape.circle,
                          ),
                          
                        ))
                  ],
                )),
            const Gap(20),
            InkWell(
              onTap: () {
                if (_selectedDate.isBefore(DateTime.now())) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Diary(
                              diary: _diaryEntries,
                              selecteddate: _selectedDate,
                            )));
              }
              else{
                customSnackBar(ctx: context, text: "Sorry,You can’t add a diary for a future date");
              }
              },
              child: CustomContainer(
                color: ElaColors.lightgreen,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          _diaryEntries != null
                              ? _diaryEntries!.title
                              : 'oops! No Diary Found ',
                          style: ElaTextStyle.title),
                      Text(
                        DateFormat('dd-MM-yyyy').format(_selectedDate),
                        style: ElaTextStyle.subTitle,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(20),
          ],
        ),
      )),
    );
  }
}