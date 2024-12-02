import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:chinese_lunar_calendar/chinese_lunar_calendar.dart';
import 'package:intl/intl.dart';

import 'b_now_date.dart';

void main() {
  runApp(MaterialApp(
    title: '八字测算',
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('zh', 'CN'),
    ],
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, });

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {

  late BuildContext _context ;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("测算"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: _buildListContainer(),
        ),
      ),
    );
  }

  Widget _buildListContainer() {
    return Container(
      child: Column(
          children: [
             _buildNowItem(),
          ]),
    );
  }


  Widget _buildNowItem() {
    return GestureDetector(
      onTap: (){
        Navigator.push(_context, MaterialPageRoute(
          builder: (_context) {
            return NowDataTime(title: '当前日期的八字测算');
          },
        ));
      },
      child: Container(
        height: 40,
        child: Text("当前日期的八字测算"),
      ),
    );
  }


  Widget _buildSelectItem() {
    return GestureDetector(
      onTap: (){
        Navigator.push(_context, MaterialPageRoute(
          builder: (_context) {
            return NowDataTime(title: '当前日期的八字测算');
          },
        ));
      },
      child: Container(
        height: 40,
        child: Text("当前日期的八字测算"),
      ),
    );
  }
}