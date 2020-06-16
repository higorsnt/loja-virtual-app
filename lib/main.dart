import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Flutter's Clothing",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}