import 'package:Geets/screens/Entry/EntryPoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MaterialApp(
    home: EntryPoint(),
    debugShowCheckedModeBanner: false,
  ));
}
