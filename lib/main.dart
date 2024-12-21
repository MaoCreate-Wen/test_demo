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

  List<Widget> Circle = [];
  @override
  Widget build(BuildContext context) {
    getImageColor();
    Size ScreenSize = MediaQuery.sizeOf(context);
    List<Widget> getCircle = [];
    // debugPrint("nihao");
    return FutureBuilder<List<Color>>(
        future: getImageColor(), // async work
        builder: (BuildContext context, AsyncSnapshot<List<Color>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else {
                Circle = [];
                for (var index = 0; index < 4; index++) {
                  if (index == 0) {
                    getCircle.add(Positioned(
                      left: ScreenSize.width - ScreenSize.width * 0.9,
                      top: ScreenSize.height - ScreenSize.height * 0.6,
                      child: ClipOval(
                        child: Container(
                          height: ScreenSize.height * 0.8,
                          width: ScreenSize.height * 0.8,
                          // margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(400),
                              color: snapshot.data![index].withAlpha(1000)),
                        ),
                      ),
                    ));
                  }
                  if (index == 1) {
                    getCircle.add(
                      Positioned(
                        left: -(ScreenSize.width - ScreenSize.width * 0.5),
                        top: -(ScreenSize.height - ScreenSize.height * 0.9),
                        child: ClipOval(
                          child: Container(
                            height: ScreenSize.height * 0.6,
                            width: ScreenSize.height * 0.6,
                            // margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(400),
                                color: snapshot.data![index].withAlpha(700)),
                          ),
                        ),
                      ),
                    );
                  }
                  if (index == 2) {
                    getCircle.add(
                      Positioned(
                        left: ScreenSize.width - ScreenSize.width * 0.6,
                        top: ScreenSize.height - ScreenSize.height,
                        child: ClipOval(
                          child: Container(
                            height: ScreenSize.height * 0.5,
                            width: ScreenSize.height * 0.5,
                            // margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(400),
                                color: snapshot.data![index].withAlpha(500)),
                          ),
                        ),
                      ),
                    );
                  }
                  if (index == 3) {
                    getCircle.add(
                      Positioned(
                        left: -(ScreenSize.width - ScreenSize.width * 0.7),
                        top: ScreenSize.height - ScreenSize.height * 0.5,
                        child: ClipOval(
                          child: Container(
                            height: ScreenSize.height * 0.5,
                            width: ScreenSize.height * 0.5,
                            // margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(400),
                                color: snapshot.data![index].withAlpha(500)),
                          ),
                        ),
                      ),
                    );
                  }
                }
                for (var i = 0; i < 4; i++) {
                  Circle.add(getCircle[3-i]);
                }
                Circle.add(BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 150.0, sigmaY: 150.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ));
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Stack(
                    children: Circle,
                  ),
                );
              }
          }
        });
  }
}
