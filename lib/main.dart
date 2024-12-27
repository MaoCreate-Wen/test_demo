import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:wenlistener/JustPlayer.dart';
import 'package:wenlistener/data.dart';
import 'package:wenlistener/playpage.dart';
import 'lyrics.dart';

const String testPicUrl =
    "https://imge.kugou.com/stdmusic/20241203/20241203113103525926.jpg";
// const String testPicUrl =
//     "https://cn.bing.com/th?id=OHR.LencoisMaranhao_ZH-CN8194406488_UHD.jpg";
// const String testPicUrl =
//     "https://gd-hbimg.huaban.com/a2bdcdbbba39c16fe2c0a1c7293252d788d99152447d6-356Leh_fw658";
const double blurValue = 200.0;
bool isPlaying = false;
PlayWay currentPlayWay = PlayWay.repeat;
StateLessdata MainData = StateLessdata();
void main() {
  TestPlayer();
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateLessdata(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 设置状态栏的颜色
        statusBarIconBrightness: Brightness.light, // 设置状态栏图标的亮度
      ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum PlayWay { repeat, shuffle }

class _MyHomePageState extends State<MyHomePage> {
  // double blurValue = 200.0;

  @override
  Widget build(BuildContext context) {
    final ListenisPlayPage = Provider.of<StateLessdata>(context);
    return Scaffold(
      body: Stack(
        children: [
          lyrcisPage(),
          Consumer(
            builder: (BuildContext context, value, Widget? child) {
              return Playpage();
            },
          ),
        ],
      ),
    );
  }
}
