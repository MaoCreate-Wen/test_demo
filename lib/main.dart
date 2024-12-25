import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:palette_generator/palette_generator.dart';

const String testPicUrl =
    "https://imge.kugou.com/stdmusic/20241203/20241203113103525926.jpg";
// const String testPicUrl =
//     "https://cn.bing.com/th?id=OHR.LencoisMaranhao_ZH-CN8194406488_UHD.jpg";
// const String testPicUrl =
//     "https://gd-hbimg.huaban.com/a2bdcdbbba39c16fe2c0a1c7293252d788d99152447d6-356Leh_fw658";
const double blurValue = 200.0;
bool isPlaying = false;
PlayWay currentPlayWay = PlayWay.repeat;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
    return const Scaffold(
      body: lyrcisPage(),
    );
  }
}

class lyrcisPage extends StatefulWidget {
  const lyrcisPage({super.key});

  @override
  _lyrcisPageState createState() => _lyrcisPageState();
}

class _lyrcisPageState extends State<lyrcisPage> {
  Future<List<Color>> getImageColor() async {
    PaletteGenerator PatGenerator = await PaletteGenerator.fromImageProvider(
      const NetworkImage(testPicUrl),
      size: const ui.Size(10, 10),
      maximumColorCount: 8,
    );
    List<({int index, double saturation})> sortColors = [];
    for (var index = 0; index < PatGenerator.paletteColors.length; index++) {
      final currentColor = PatGenerator.paletteColors[index].color;
      double lightValue = HSVColor.fromColor(currentColor).value;
      if (lightValue < 0.3 || lightValue > 0.7) {
        continue;
      }
      sortColors.add((
        index: index,
        saturation: HSVColor.fromColor(currentColor).saturation
      ));
    }

    for (var i = 0; i < sortColors.length; i++) {
      for (var i1 = 0; i1 < (sortColors.length - 1 - i); i1++) {
        if (sortColors[i1].saturation < sortColors[i1 + 1].saturation) {
          final temp = sortColors[i1 + 1];
          sortColors[i1 + 1] = sortColors[i1];
          sortColors[i1] = temp;
        }
      }
    }

    List<Color> outputColors = [];
    for (var index = 0; index < sortColors.length; index++) {
      outputColors
          .add(PatGenerator.paletteColors[sortColors[index].index].color);
      print(HSVColor.fromColor(
              PatGenerator.paletteColors[sortColors[index].index].color)
          .value);
    }
    print(outputColors);
    return outputColors;
  }

  List<Widget> circleList = [];
  @override
  Widget build(BuildContext context) {
    getImageColor();
    Size ScreenSize = MediaQuery.sizeOf(context);
    List<Widget> getCircle = [];
    return FutureBuilder<List<Color>>(
        future: getImageColor(),
        builder: (BuildContext context, AsyncSnapshot<List<Color>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else {
                circleList = [];
                for (var index = 0; index < 4; index++) {
                  if (index == 0) {
                    getCircle.add(Positioned(
                      left: ScreenSize.width * 0.1,
                      top: ScreenSize.height * 0.5,
                      // top: ScreenSize.height * 0.4,
                      child: OverflowBox(
                        maxWidth: double.infinity,
                        maxHeight: double.infinity,
                        child: ClipOval(
                          child: Container(
                            height: ScreenSize.height * 0.7,
                            width: ScreenSize.height * 0.7,
                            decoration: BoxDecoration(
                                color: snapshot.data![index].withAlpha(1000)),
                          ),
                        ),
                      ),
                    ));
                  }
                  if (index == 1) {
                    getCircle.add(
                      Positioned(
                        left: -(ScreenSize.width * 0.5),
                        top: ScreenSize.height * 0.2,
                        // top: -(ScreenSize.height * 0.1),
                        child: OverflowBox(
                          maxWidth: double.infinity,
                          maxHeight: double.infinity,
                          child: ClipOval(
                            child: Container(
                              height: ScreenSize.height * 0.6,
                              width: ScreenSize.height * 0.6,
                              decoration: BoxDecoration(
                                  color: snapshot.data![index].withAlpha(700)),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (index == 2) {
                    getCircle.add(
                      Positioned(
                        left: ScreenSize.width * 0.4,
                        top: ScreenSize.height * 0.2,
                        // top: 0,
                        child: OverflowBox(
                          maxWidth: double.infinity,
                          maxHeight: double.infinity,
                          child: ClipOval(
                            child: Container(
                              height: ScreenSize.height * 0.5,
                              width: ScreenSize.height * 0.5,
                              decoration: BoxDecoration(
                                  color: snapshot.data![index].withAlpha(500)),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (index == 3) {
                    getCircle.add(
                      Positioned(
                        left: -(ScreenSize.width * 0.3),
                        top: ScreenSize.height * 0.6,
                        // top: ScreenSize.height * 0.5,
                        child: OverflowBox(
                          maxWidth: double.infinity,
                          maxHeight: double.infinity,
                          child: ClipOval(
                            child: Container(
                              height: ScreenSize.height * 0.5,
                              width: ScreenSize.height * 0.5,
                              decoration: BoxDecoration(
                                  color: snapshot.data![index].withAlpha(500)),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }
                for (var i = 0; i < 4; i++) {
                  circleList.add(getCircle[3 - i]);
                }
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Stack(
                    children: [
                      RotatingCircles(
                        circleList: circleList,
                      ),
                      BackdropFilter(
                        filter:
                            ui.ImageFilter.blur(sigmaX: 150.0, sigmaY: 150.0),
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        });
  }
}

class RotatingCircles extends StatefulWidget {
  final List<Widget> circleList;
  const RotatingCircles({super.key, required this.circleList});

  @override
  _RotatingCirclesState createState() => _RotatingCirclesState();
}

class _RotatingCirclesState extends State<RotatingCircles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )
    ..repeat()
    ;
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<AnimatedBuilder> addAnimatedBuilder(List<Widget> circleList) {
    List<AnimatedBuilder> animatedBuildersList = [];

    for (var index = 0; index < circleList.length; index++) {
      animatedBuildersList.add(AnimatedBuilder(
        animation: _animation,
        child: circleList[index],
        builder: (context, child) {
          final angle = _animation.value + (index * 2 * pi / circleList.length);
          final offset = Offset(100 * cos(angle), 100 * sin(angle));
          return Transform.translate(
            offset: offset,
            child: child,
          );
        },
      ));
    }
    return animatedBuildersList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: addAnimatedBuilder(widget.circleList));
  }
}
