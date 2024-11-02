import 'package:ela/controllers/water_goal_function.dart';
import 'package:ela/model/mood/mood_model.dart';
import 'package:ela/model/gaols/water/water_model.dart';
import 'package:ela/view/theme/app_color.dart';
import 'package:ela/view/widget/drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/user_functions.dart';
import '../model/user/user.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  User? _user;
  User? userdata;
  Future<List<FlSpot>>? _spotsFuture;
  late Map<DateTime, String> moodDatabase;
  // water
  double _currentIntake = 0.0;
  final double _dailyGoal = 2000.0; 
  // ------------------

// ------------------------------------
  List<MoodModel> weeklyMoodData = [];
  late Box<MoodModel> moodBox;
// --------------------------------------

  @override
  void initState() {
    super.initState();
    loaddata();
    openBoxAndLoadData();
  }

  







  void loaddata() async {
    userdata = await fetchUserdata();
    setState(() {
      _user = userdata;
    });
  }

  @override
  Future<void> openBoxAndLoadData() async {
    // Initialize Hive and open the box
    await Hive.initFlutter();
    moodBox = await Hive.openBox<MoodModel>('mood');
    loadWeeklyMoodData();
  }

  String formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  void loadWeeklyMoodData() {
    final now = DateTime.now();
    final weekData = <MoodModel>[];

    for (int i = 0; i < 7; i++) {
      final date = now.subtract(Duration(days: i));
      final formattedDate = formatDate(date);
      final moodData = moodBox.get(formattedDate);
      if (moodData != null) {
        weekData.add(moodData);
      }
    }
    setState(() {
      weeklyMoodData = weekData.reversed.toList(); // Display oldest to newest
    });
  }

// NEW FOR GRAPH -8--8-8-88-8-8-8-8-8---------------- - - - - - - --  - -- - - -  -- - - -- - - -

// FOR GRAPH --------------------------------- -- -- - -- - - - -- - - -- - - - - -- - -

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 35,
                    width: 85,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(245, 255, 210, 1),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                Text('ELA', style: GoogleFonts.kalnia(fontSize: 40))
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 10),
              child: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Image(
                      height: 35,
                      width: 35,
                      image: AssetImage('assets/icons/setting-lines.png')),
                );
              }),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromRGBO(245, 255, 210, 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 12, 2, 10),
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 200,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            height: 140,
                            width: 140,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: _user?.image == null
                                    ? const Image(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/IMG_7399.JPG'))
                                    : Image.memory(
                                        _user!.image!,
                                        fit: BoxFit.fill,
                                      ))),
                      )
                    ]),
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: weeklyMoodData.isEmpty
                          ? const Center(
                              child: Text(
                                  'No mood data available for the past week'))
                          : SfCartesianChart(
                              plotAreaBackgroundColor: ElaColors.lightgrey,
                              primaryXAxis: const CategoryAxis(
                                  // title: AxisTitle(text: 'Day'),
                                  ),
                              primaryYAxis: const NumericAxis(
                                // title: AxisTitle(text: 'Mood Level'),
                                minimum: 0,
                                maximum: 6,
                                interval: 1,
                                // axisLabelFormatter:,
                              ),
                              series: [
                                LineSeries<MoodModel, String>(
                                  dataSource: weeklyMoodData,
                                  xValueMapper: (MoodModel mood, _) =>
                                      mood.date.day.toString(),
                                  yValueMapper: (MoodModel mood, _) =>
                                      moodToValue(mood.mood),
                                  markerSettings:
                                      const MarkerSettings(isVisible: true),
                                  name: 'Mood',
                                ),
                                ColumnSeries<MoodModel, String>(
                                  dataSource: weeklyMoodData,
                                  xValueMapper: (MoodModel mood, _) => mood.date.day.toString(),
                                  yValueMapper: (MoodModel mood, _) => moodToValue(mood.mood),
                                  // name: 'Mood Levels',
                                  pointColorMapper: (MoodModel mood, _)=> colorselector(mood.mood),
                                  width: 0.6,
                                )
                              ],
                              // title: const ChartTitle(text: 'Mood Over the Past Week'),
                            ),
                    ),
                  )
                ]))));

    //                     const Gap(10),
    //                 Column( 
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       _user?.name ?? 'Not Available',
    //                       style: ElaTextStyle.title,
    //                     ),
    //                     const SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text(_user?.address ?? 'Not Available',style: ElaTextStyle.subTitle,),
    //                     const SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text(_user?.dob?? 'Not Available',style: ElaTextStyle.subTitle,),
    //                     const SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text(_user?.phone.toString() ?? 'Not Available',style: ElaTextStyle.subTitle,)
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 30,
    //           ),
    //           Align(
    //             alignment: Alignment.centerLeft,
    //             child: Stack(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 5.0),
    //                   child: Container(
    //                     height: 26,
    //                     width: 70,
    //                     decoration: BoxDecoration(
    //                         color: const Color.fromRGBO(245, 255, 210, 1),
    //                         borderRadius: BorderRadius.circular(5)),
    //                   ),
    //                 ),
    //                 const Text(
    //                   'Goals',
    //                   style: TextStyle(
    //                       fontSize: 25, fontWeight: FontWeight.w500),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           CarouselSlider(
    //             options: CarouselOptions(
    //               height: 300,
    //               autoPlay: true,
    //               enlargeCenterPage: true,
    //               aspectRatio: 16 / 9,
    //               viewportFraction: 0.8,
    //             ),
    //             items: containerList.map((container) {
    //               return Builder(
    //                 builder: (BuildContext context) {
    //                   return container;
    //                 },
    //               );
    //             }).toList(),
    //           ),
    //           const SizedBox(
    //             height: 50,
    //           ),

    //         ]))),
    drawer:
    CustomDrawer(context: context);
  }

  dynamic colorselector(String mood) {
    switch (mood) {
      case 'excelent':
        return ElaColors.emojicolor1;
      case 'very good':
        return ElaColors.emojicolor2;
      case 'good':
        return ElaColors.emojicolor3;
      case 'not bad':
        return ElaColors.emojicolor4;
      case 'bad':
        return ElaColors.emojicolor5;
      case 'very bad':
        return ElaColors.emojicolor6;
      default:
        return const Color.fromARGB(255, 255, 255, 255);
    }
  }

  int moodToValue(String mood) {
    switch (mood) {
      case 'excelent':
        return 6;
      case 'very good':
        return 5;
      case 'good':
        return 4;
      case 'not bad':
        return 3;
      case 'bad':
        return 2;
      case 'very bad':
        return 1;
      default:
        return 0;
    }
  }
}
