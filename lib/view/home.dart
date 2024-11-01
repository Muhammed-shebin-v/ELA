import 'dart:async';
import 'package:ela/controllers/quote.dart';
import 'package:ela/controllers/todo_function.dart';
import 'package:ela/model/todo/todo_model.dart';
import 'package:ela/view/todo_list.dart';
import 'package:ela/view/theme/app_color.dart';
import 'package:ela/view/theme/app_textstyle.dart';
import 'package:ela/view/widget/drawer.dart';
import '../controllers/user_functions.dart';
import '../model/user/user.dart';
import 'widget/container.dart';
import 'widget/emoji_icon.dart';
import 'widget/home_linearindicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreeen> {
  String? greet;
  Quote? currentQuote;
  Timer? _timer;
  List<TodoModel> latestTodos = [];

  User? user;
  @override
  void initState() {
    super.initState();
    loaddata();
    greet = getGreeting();
    _updateQuote();
    _startTimer();
    loadtodo();
  }

  void loaddata() async {
    user = await fetchuser().whenComplete(
      () {
        setState(() {});
      },
    );
  }

  void loadtodo() async {
    latestTodos = await fetchLatestTodos();
  }

  void _updateQuote() {
    int hour = DateTime.now().hour;
    setState(() {
      currentQuote = quotes[hour % quotes.length];
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(hours: 1), (timer) {
      _updateQuote();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ElaColors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Builder(builder: (context) {
                          return InkWell(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: const ImageIcon(
                              AssetImage('assets/icons/hamburger.png'),
                              size: 40,
                            ),
                          );
                        }),
                      ),
                      Flexible(
                          child: Text(
                        'Hello ${user?.name ?? 'unknown'}, $greet',
                        style: GoogleFonts.kalnia(fontSize: 28),
                      )),
                      
                    Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  height: 40,
                                  width: 85,
                                  decoration: BoxDecoration(
                                      color: ElaColors.lightgreen,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                              Text('ELA', style: GoogleFonts.kalnia(fontSize: 40))
                            ],
                          )
                    ],
                  ),
                  const Gap(20),
                  CustomContainer(
                    color: ElaColors.lightgreen,
                    boxshadow: true,
                    child: currentQuote != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  '"${currentQuote!.text}"',
                                  style: ElaTextStyle.small,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, bottom: 10),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "- ${currentQuote!.author}",
                                    style: ElaTextStyle.small,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const CircularProgressIndicator(),
                  ),
                  const Gap(15),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TodoList()));
                      },
                      child: CustomContainer(
                          color: ElaColors.white,
                          boxshadow: true,
                          height: 150,
                          child: latestTodos.isNotEmpty
                              ? ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: latestTodos.length,
                                  itemBuilder: (context, index) {
                                    int reverseIndex =
                                        latestTodos.length - 1 - index;
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: latestTodos[reverseIndex]
                                                  .isDone,
                                              onChanged: null,
                                              activeColor: const Color.fromRGBO(
                                                  194, 246, 58, 1),
                                              checkColor: const Color.fromRGBO(
                                                  0, 0, 0, 1),
                                            ),
                                            Expanded(
                                              child: Text(
                                                latestTodos[reverseIndex]
                                                        .content ??
                                                    'no content',
                                                style: ElaTextStyle.title,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ));
                                  })
                              : const Center(
                                  child: Text(
                                    'oops! add a todo first',
                                    style: ElaTextStyle.subHeading,
                                  ),
                                ))),
                  const Gap(15),
                  const CustomContainer(
                    color: ElaColors.lightgreen,
                    boxshadow: true,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CustomHomeLinearIndicator(title: 'Water', value: 0.9),
                          Gap(20),
                          CustomHomeLinearIndicator(title: 'Sleep', value: 0.2),
                          Gap(20),
                          CustomHomeLinearIndicator(title: 'Walking', value: 0.7),
                          Gap(20),
                          CustomHomeLinearIndicator(title: 'Reading', value: 0.9),
                        ],
                      ),
                    ),
                  ),
                  const Gap(15),
                  CustomContainer(
                    boxshadow: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(50),
                              const Text(
                                'How was your day?',
                                style: ElaTextStyle.title,
                              ),
                              const Gap(20),
                              Row(
                                children: [
                                  CustomEmojiIcon(
                                      ctx: context,
                                      mood: 'excelent',
                                      imagepath: 'assets/icons/smiley.png',
                                      customcolor: ElaColors.emojicolor1),
                                  CustomEmojiIcon(
                                      ctx: context,
                                      mood: 'very good',
                                      imagepath: 'assets/icons/happy.png',
                                      customcolor: ElaColors.emojicolor2),
                                  CustomEmojiIcon(
                                      ctx: context,
                                      mood: 'good',
                                      imagepath: 'assets/icons/happy-3.png',
                                      customcolor: ElaColors.emojicolor3),
                                  CustomEmojiIcon(
                                      ctx: context,
                                      mood: 'not bad',
                                      imagepath: 'assets/icons/happiness.png',
                                      customcolor: ElaColors.emojicolor4),
                                  CustomEmojiIcon(
                                    ctx: context,
                                    mood: 'bad',
                                    imagepath: 'assets/icons/neutral.png',
                                    customcolor: ElaColors.emojicolor5,
                                  ),
                                  CustomEmojiIcon(
                                    ctx: context,
                                    mood: 'very bad',
                                    imagepath: 'assets/icons/sad.png',
                                    customcolor: ElaColors.emojicolor6,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0, top: 3),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 120, maxWidth: 120),
                              child: const Image(
                                image: AssetImage('assets/images/mood-image.jpg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: CustomDrawer(context: context));
  }
}
