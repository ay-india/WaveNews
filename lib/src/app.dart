import "package:flutter/material.dart";
import 'package:wave_news/src/screen/home.dart';
import 'package:wave_news/src/screen/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
