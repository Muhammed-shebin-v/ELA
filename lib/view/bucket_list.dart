import 'dart:developer';
import 'package:ela/controllers/bucket_function.dart';
import 'package:ela/model/bucket/bucket_model.dart';
import 'package:ela/view/theme/app_color.dart';
import 'package:ela/view/theme/app_textstyle.dart';
import 'package:ela/view/widget/button.dart';
import 'package:ela/view/widget/container.dart';
import 'package:ela/view/widget/delete_bucket.dart';
import 'package:gap/gap.dart';
import 'bucket_create.dart';
import 'bucket_edit.dart';
import 'widget/heading.dart';
import 'package:flutter/material.dart';

class BucketList extends StatefulWidget {
  const BucketList({super.key});

  @override
  State<BucketList> createState() => _BucketListState();
}

class _BucketListState extends State<BucketList> {
  List<BucketModel> buckets = [];
  List<BucketModel> _filtered = [];
  @override
  void initState() {
    super.initState();
    initwork();
    _selectedValue = _dropDownItems[0];
  }

  Future<void> loaddata() async {
    buckets = await getBucket();
    bucketNotifier.value = buckets;
    log('getdata worked');
    _filter(selectedIndex ??= 0);
  }

  Future<void> initwork() async {
    await loaddata();
    _filtered = buckets;
  }

  void _filter(int filterindex) {
    setState(() {
      if (filterindex != 0) {
        _filtered = buckets
            .where((bucket) => bucket.catogarynumber == filterindex - 1)
            .toList();
      } else {
        _filtered = buckets;
      }
    });
  }

  final List<String> _dropDownItems = ['All', 'Travel', 'Activity', 'Purchase'];
  String? _selectedValue;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Gap(90),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                    iconSize: 35,
                  ),
                  const CustomHeading(
                    heading: 'Bucket List.',
                    length: 175,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomContainer(
                  height: 700,
                  color: ElaColors.lightgrey,
                  boxshadow: true,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomContainer(
                                height: 35,
                                color: ElaColors.lightgreen,
                                child: 
                                DropdownButton(
                                  value: _selectedValue,
                                  dropdownColor: ElaColors.lightgreen,
                                  onChanged: (String? newvalue) {
                                    setState(() {
                                      _selectedValue = newvalue;
                                      selectedIndex =_dropDownItems.indexOf(newvalue!);
                                      _filter(selectedIndex!);
                                    });
                                  },
                                  items: _dropDownItems
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      alignment: AlignmentDirectional.topStart,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 9.0, top: 4),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                )
                                ),
                            InkWell(
                                onTap: () {
                                  _navigateToCreatePage(context);
                                },
                                child: CustomButton(
                                  text: 'New',
                                  button: true,
                                )),
                          ],
                        ),
                        const Gap(20),
                        bucketListUI()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  

  Widget bucketListUI() {
    return ValueListenableBuilder<List<BucketModel>>(
        valueListenable: bucketNotifier,
        builder: (context, box, widget) {
          if (_filtered.isEmpty) {
            return const Column(
              children: [
                Gap(100),
                Center(
                  child: Text(
                    'No BucketList',
                    style: ElaTextStyle.heading,
                  ),
                ),
              ],
            );
          }
          return CustomContainer(
            color: ElaColors.lightgreen,
            height: 590,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListView.builder(
                itemCount: _filtered.length,
                itemBuilder: (context, index) {
                  int reverseIndex = _filtered.length - 1 - index;
                  final bucketItem = _filtered[reverseIndex];
                  final int daysLeft = calculateDaysLeft(bucketItem.finalDate!);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BucketEdit(
                                    index: reverseIndex,
                                    bucket: bucketItem,
                                    readonly: true,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(bucketItem.title ?? 'invalid',
                                      style: ElaTextStyle.subHeading),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BucketEdit(
                                                    index: reverseIndex,
                                                    bucket: bucketItem,
                                                    readonly: false,
                                                  )));
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () async{
                                      deleteBucketItem(deleteIndex: reverseIndex, context: context);
                                      await loaddata();
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Days Left:$daysLeft'),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  

  Future<void> _navigateToCreatePage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BucketView()),
    );
    if (result == true) {
      initwork();
    }
  }
}
