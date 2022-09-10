import 'package:create_demo/views/share.dart';
import 'package:flutter/material.dart';
import 'FetchContact.dart';
import 'imagepicker.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FetchContact(),
    );
  }
}
