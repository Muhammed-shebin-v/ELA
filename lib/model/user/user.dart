import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId:0)

class User {

@HiveField(0) 
String name;

@HiveField(1)
String address;

@HiveField(2)
String dob;

@HiveField(4)
int phone;

@HiveField(5)
Uint8List? image;

User({
  required this.name,
  required this.address,
  required this.dob,
  required this.phone,
  this.image
});

}
