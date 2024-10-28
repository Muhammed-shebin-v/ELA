import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

import '../model/user/user.dart';
import 'package:hive/hive.dart';

Future<void> addUser({required User user}) async {
  final userdb = await Hive.openBox<User>('user');
  log('useradded ${userdb.name}');
  log('User Added: Name: ${user.name}, Email: ${user.address}, Age: ${user.phone}');
  await userdb.put('userdata', user);
}

Future<User?> fetchuser() async {
  final name = await Hive.openBox<User>('user');
  return name.get('userdata');
}

Future<User?> fetchUserdata() async {
  final userBox = await Hive.openBox<User>('user');
  User? user = userBox.get('userdata');
  if(user?.image!=null){
    log('image is stored and fetched');
  }
  if (user!=null) {
    return user;
  } else {
    return null;
  }
}


Future<Uint8List?> pickSaveImage() async{
  final ImagePicker pick=ImagePicker();
  final XFile? imagefile =await pick.pickImage(source: ImageSource.gallery);
  log('image picked');
 if(imagefile!=null){
   Uint8List imageBytes=await File(imagefile.path).readAsBytes();
   log('image converted into bytes');
   return imageBytes;
 }
 else{
  log('no image found');
 }
 return null;
}


