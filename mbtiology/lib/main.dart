import 'package:flutter/material.dart';
import 'package:mbtiology/1_home_screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NanumMyeongjo',
      ),
      home: const HomeScreen(),
    ),
  );
}
