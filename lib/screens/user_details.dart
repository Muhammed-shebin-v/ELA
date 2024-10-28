import 'package:carousel_slider/carousel_slider.dart';
import 'package:ela/screens/user_edit.dart';
import 'package:ela/theme/app_color.dart';
import 'package:ela/theme/app_textstyle.dart';
import 'package:ela/widget/about.dart';
import 'package:ela/widget/drawer.dart';
import 'package:ela/widget/legal_terms.dart';
import 'package:ela/widget/privacy_policy.dart';
import 'package:gap/gap.dart';
import '../database/user_functions.dart';
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

  @override
  void initState() {
    super.initState();
    loaddata();
    // _spotsFuture = fetchData();
  }

  void loaddata() async {
    userdata = await fetchUserdata();
    setState(() {
      _user = userdata;
    });
  }


//  Future<List<FlSpot>> fetchData() async {
//   final box = await Hive.openBox<MoodModel>('mood');
//   List<FlSpot> spots = [];

//   for (var data in box.values) {
//     // Attempt to parse the mood value as a double, ensure it's valid
//     double value = double.tryParse(data.mood) ?? 0.0;

//     // Convert DateTime to a double using millisecondsSinceEpoch
//     double xValue = data.date.millisecondsSinceEpoch.toDouble();

//     // Check if both xValue and value are finite numbers
//     if (xValue.isFinite && !xValue.isNaN && value.isFinite && !value.isNaN) {
//       spots.add(FlSpot(xValue, value));
//     }
//   }

//   return spots;
// }




 

  @override

  //  Future<void> _fetchAndDisplayUser() async {
  //   User? user = await fetchUserdata();  // Fetch the user data from Hive

  //   // Update the state to reflect the fetched data
  //   setState(() {
  //     _user = user;

  //   });
  // }
  final List<Widget> containerList = [
    Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 211, 238, 104),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 12, 2, 10),
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: LineChart(LineChartData(
          maxY: 5000, // Maximum limit for steps
          minY: 0,
          gridData: const FlGridData(show: true), // Grid lines
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Sun');
                    case 1:
                      return const Text('Mon');
                    case 2:
                      return const Text('Tue');
                    case 3:
                      return const Text('Wed');
                    case 4:
                      return const Text('Thu');
                    case 5:
                      return const Text('Fri');
                    case 6:
                      return const Text('Sat');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1000, // Steps interval for Y-axis
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}'); // Display step count
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 2000),
                const FlSpot(1, 1100),
                const FlSpot(2, 2000),
                const FlSpot(3, 3800),
                const FlSpot(4, 1700),
                const FlSpot(5, 4500),
                const FlSpot(6, 2900),
              ],
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ))),
    Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 220, 221, 216),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 12, 2, 10),
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: LineChart(LineChartData(
          maxY: 5000, // Maximum limit for steps
          minY: 0,
          gridData: const FlGridData(show: true), // Grid lines
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Sun');
                    case 1:
                      return const Text('Mon');
                    case 2:
                      return const Text('Tue');
                    case 3:
                      return const Text('Wed');
                    case 4:
                      return const Text('Thu');
                    case 5:
                      return const Text('Fri');
                    case 6:
                      return const Text('Sat');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1000, // Steps interval for Y-axis
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}'); // Display step count
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 4200),
                const FlSpot(1, 2100),
                const FlSpot(2, 2000),
                const FlSpot(3, 1800),
                const FlSpot(4, 2700),
                const FlSpot(5, 2500),
                const FlSpot(6, 2900),
              ],
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ))),
    Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 213, 238, 112),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 12, 2, 10),
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: LineChart(LineChartData(
          maxY: 5000, // Maximum limit for steps
          minY: 0,
          gridData: const FlGridData(show: true), // Grid lines
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Sun');
                    case 1:
                      return const Text('Mon');
                    case 2:
                      return const Text('Tue');
                    case 3:
                      return const Text('Wed');
                    case 4:
                      return const Text('Thu');
                    case 5:
                      return const Text('Fri');
                    case 6:
                      return const Text('Sat');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1000, // Steps interval for Y-axis
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}'); // Display step count
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 3200),
                const FlSpot(1, 3100),
                const FlSpot(2, 2000),
                const FlSpot(3, 1800),
                const FlSpot(4, 1700),
                const FlSpot(5, 1500),
                const FlSpot(6, 2900),
              ],
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ))),
    Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 220, 221, 216),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 12, 2, 10),
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: LineChart(LineChartData(
          maxY: 5000, // Maximum limit for steps
          minY: 0,
          gridData: const FlGridData(show: true), // Grid lines
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Sun');
                    case 1:
                      return const Text('Mon');
                    case 2:
                      return const Text('Tue');
                    case 3:
                      return const Text('Wed');
                    case 4:
                      return const Text('Thu');
                    case 5:
                      return const Text('Fri');
                    case 6:
                      return const Text('Sat');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1000, // Steps interval for Y-axis
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}'); // Display step count
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 4200),
                const FlSpot(1, 2100),
                const FlSpot(2, 2000),
                const FlSpot(3, 1800),
                const FlSpot(4, 2700),
                const FlSpot(5, 2500),
                const FlSpot(6, 2900),
              ],
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ))),
  ];


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
              child: Builder(
                builder: (context) {
                  return InkWell(
                    onTap: (){
                    Scaffold.of(context).openDrawer();
                    },
                     
                    child: const Image(
                        height: 35,
                        width: 35,
                        image: AssetImage('assets/icons/setting-lines.png')),
                  );
                }
              ),
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
                    child: Row(
                      children: [
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
                                      )
                                      
                                         )),
                            ),
                            const Gap(10),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _user?.name ?? 'Not Available',
                              style: ElaTextStyle.title,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(_user?.address ?? 'Not Available',style: ElaTextStyle.subTitle,),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(_user?.dob?? 'Not Available',style: ElaTextStyle.subTitle,),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(_user?.phone.toString() ?? 'Not Available',style: ElaTextStyle.subTitle,)
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            height: 26,
                            width: 70,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(245, 255, 210, 1),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const Text(
                          'Goals',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                    ),
                    items: containerList.map((container) {
                      return Builder(
                        builder: (BuildContext context) {
                          return container;
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // const Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'Mood',
                  //       style: TextStyle(fontSize: 25),
                  //     )),
                  // Container(
                  //     height: 300,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(width: 1.5),
                  //       borderRadius: BorderRadius.circular(30),
                  //       color: const Color.fromARGB(255, 213, 238, 112),
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           color: Color.fromARGB(255, 12, 2, 10),
                  //           offset: Offset(0, 4),
                  //         ),
                  //       ],
                  //     ),
                  //     child: LineChart(LineChartData(
                  //       maxY: 5000, // Maximum limit for steps
                  //       minY: 0,
                  //       gridData: const FlGridData(show: true), // Grid lines
                  //       titlesData: FlTitlesData(
                  //         bottomTitles: AxisTitles(
                  //           sideTitles: SideTitles(
                  //             showTitles: true,
                  //             getTitlesWidget: (value, meta) {
                  //               switch (value.toInt()) {
                  //                 case 0:
                  //                   return const Text('Sun');
                  //                 case 1:
                  //                   return const Text('Mon');
                  //                 case 2:
                  //                   return const Text('Tue');
                  //                 case 3:
                  //                   return const Text('Wed');
                  //                 case 4:
                  //                   return const Text('Thu');
                  //                 case 5:
                  //                   return const Text('Fri');
                  //                 case 6:
                  //                   return const Text('Sat');
                  //                 default:
                  //                   return const Text('');
                  //               }
                  //             },
                  //           ),
                  //         ),
                  //         leftTitles: AxisTitles(
                  //           sideTitles: SideTitles(
                  //             showTitles: true,
                  //             interval: 1000, // Steps interval for Y-axis
                  //             getTitlesWidget: (value, meta) {
                  //               return Text(
                  //                   '${value.toInt()}'); // Display step count
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //       borderData: FlBorderData(show: true),
                  //       lineBarsData: [
                  //         LineChartBarData(
                  //           spots: [
                  //             const FlSpot(0, 3200),
                  //             const FlSpot(1, 3100),
                  //             const FlSpot(2, 2000),
                  //             const FlSpot(3, 1800),
                  //             const FlSpot(4, 1700),
                  //             const FlSpot(5, 1500),
                  //             const FlSpot(6, 2900),
                  //           ],
                  //           barWidth: 4,
                  //           belowBarData: BarAreaData(show: false),
                  //         ),
                  //       ],
                  //     ))),


      //           Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: HeatMapCalendar(
      //     // input: heatMapData,
      //     // colorsets: ,
      //     // weekDaysLabels: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
      //     // monthsLabels: ['January', 'February', 'March', 'April', 'May', 'June', 
      //     //                'July', 'August', 'September', 'October', 'November', 'December'],
      //     // squareSize: 40.0,
      //     // textOpacity: 0.3,
      //     // labelTextColor: Colors.black,
      //     // dayTextColor: Colors.black,
      //   ),
      // ),


      // const Text(
      //       'Your Moods Over the Month',
      //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //     ),
      //     const SizedBox(height: 20),
      //     Expanded(
      //       flex: 8,
          
      //       child:LineChart(
              
      //     LineChartData(
            
      //       titlesData: FlTitlesData(
      //         leftTitles: AxisTitles(
      //           sideTitles: SideTitles(showTitles: true),
      //         ),
      //         bottomTitles: AxisTitles(
      //           sideTitles: SideTitles(showTitles: true),
      //         ),
      //       ),
      //       borderData: FlBorderData(show: true),
      //       gridData: FlGridData(show: true),
      //       lineBarsData: [
      //         LineChartBarData(
      //           spots: _moodSpots,
      //           isCurved: true,
      //           color: Colors.blue,
      //           barWidth: 4,
      //           isStrokeCapRound: true,
      //         )
      //       ],
      //     )))


// FutureBuilder<List<FlSpot>>(
//       future: _spotsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Text('No data available');
//         }

//         // Get the data from the snapshot
//         List<FlSpot> spots = snapshot.data!;

//         // Create the LineChart using the retrieved spots
//         return LineChart(
//           LineChartData(
//             minX: spots.first.x,
//             maxX: spots.last.x,
//             minY: 0,
//             maxY: 3, // Adjust this based on your mood value range
//             lineBarsData: [
//               LineChartBarData(
//                 spots: spots,
//                 isCurved: true,
//                 barWidth: 2,
//                 color: Colors.blue,
//                 belowBarData: BarAreaData(show: false),
//               ),
//             ],
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (value, meta) {
//                     // Convert x-axis value back to DateTime for display
//                     DateTime date =
//                         DateTime.fromMillisecondsSinceEpoch(value.toInt());
//                     return Text('${date.day}/${date.month}');
//                   },
//                 ),
//               ),
//               leftTitles: const AxisTitles(
//                 sideTitles: SideTitles(showTitles: true),
//               ),
//             ),
//           ));
//       })
                ]))),
                drawer: CustomDrawer(context: context)
                );
  }
//   Color _getMoodColor(String mood) {
//   switch (mood) {
//     case 'Happy':
//       return Colors.green;
//     case 'Sad':
//       return Colors.blue;
//     case 'Angry':
//       return Colors.red;
//     case 'Neutral':
//       return Colors.yellow;
//     default:
//       return Colors.grey; // For days with no mood or unknown values
//   }
// }
// final Map<int, Color> colorSets = {
//   0: Colors.grey,   // Default or no mood
//   1: Colors.blue,   // Sad
//   2: Colors.yellow, // Neutral
//   3: Colors.green,  // Happy
// };
// Map<DateTime, int> _prepareHeatMapData(Map<DateTime, String> moodData) {
//   Map<DateTime, int> heatMapData = {};

//   moodData.forEach((date, mood) {
//     heatMapData[date] = _getMoodColor(mood);
//   });

//   return heatMapData;
// }






// // Format x-axis labels (e.g., dates)
//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Text(
//         '${date.day}/${date.month}',  // Example: 12/10 for 12th October
//         style: const TextStyle(fontSize: 10),
//       ),
//     );
//   }

//   // Format y-axis labels (e.g., values)
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     return Text(
//       value.toStringAsFixed(1),  // Round to 1 decimal place for simplicity
//       style: const TextStyle(fontSize: 10),
//     );
//   }

}
