
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/database_helper.dart';

class ConverterController extends GetxController
{
  TextEditingController txtName=TextEditingController();
  TextEditingController txtPhone=TextEditingController();
  TextEditingController txtChat=TextEditingController();
  int selectedIndex=0;
  late String date;
  late String time;
  Rx<File>? ImgPath;
  RxString fileImagePath="".obs;
  RxList data = [].obs;

  @override
  Future<void> onInit() async {
    initDb();
    await readData();
    super.onInit();
  }
  Future<void> initDb()
  async {
    await DbHelper.dbHelper.database;
  }

  void setImg(File img) {
    ImgPath = img.obs;
  }

  Future<void> insertData(String img,String time,String date,String bio,String call,String name)
  async {
    await DbHelper.dbHelper.insertData(img, time, date, bio, call, name);
    await readData();
  }

  Future<RxList> readData()
  async {
    data.value=await DbHelper.dbHelper.readData();
    return data;
  }

  Future<void> removeData(int id)
  async {
    await DbHelper.dbHelper.removeData(id);
    await readData();
  }

  Future<void> updateData(String name,String phone,String chat,String img,int id) async {
    await DbHelper.dbHelper.updateData(name, phone, chat, img, id);
    readData();
  }

}
