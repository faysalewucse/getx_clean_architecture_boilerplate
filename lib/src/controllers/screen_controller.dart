import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/category/category_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/home/home_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/products/products_screen.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/views/profile/profile_screen.dart';

class ScreenController extends GetxController{
  final RxInt currentIndex = 0.obs;

  final List<Widget> pages = [
    HomeScreen(),
    CategoryScreen(),
    ProductsScreen(),
    ProfileScreen(),
  ];

  void changePageIndex(int index){
    currentIndex.value = index;
  }
}