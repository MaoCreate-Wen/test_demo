import 'dart:math';
import 'dart:ui';

import 'package:amlv/amlv.dart';
import 'package:lrc/lrc.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:wenlistener/data.dart';
import 'package:wenlistener/main.dart';
import 'dart:ui' as ui;

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
      home: LyricsWidget(
        width: 100,
        lyricsdata: """
[00:00.00]歌曲名 发如雪 歌手名 周杰伦\r\n[00:01.00]作词：方文山\r\n[00:02.00]作曲：周杰伦\r\n[00:22.40]狼牙月伊人憔悴\r\n[00:26.14]我举杯饮尽了风雪\r\n[00:32.22]是谁打翻前世柜\r\n[00:36.36]惹尘埃是非\r\n[00:38.46]缘字诀几番轮回\r\n[00:42.65]你锁眉哭红颜唤不回\r\n[00:48.74]纵然青史已经成灰\r\n[00:52.83]我爱不灭\r\n[00:56.58]繁华如三千东流水\r\n[01:00.22]我只取一瓢爱了解\r\n[01:04.41]只恋你化身的蝶\r\n[01:10.15]你发如雪凄美了离别\r\n[01:14.69]我焚香感动了谁\r\n[01:19.28]邀明月让回忆皎洁\r\n[01:23.42]爱在月光下完美\r\n[01:26.61]你发如雪纷飞了眼泪\r\n[01:31.20]我等待苍老了谁\r\n[01:35.74]红尘醉微醺的岁月\r\n[01:40.28]我用无悔刻永世爱你的碑\r\n[01:45.16]你发如雪\r\n[01:45.86]凄美了离别\r\n[01:47.16]我焚香感动了谁\r\n[01:49.10]邀明月让回忆皎洁\r\n[01:51.20]爱在月光下完美\r\n[01:53.39]你发如雪纷飞了眼泪\r\n[01:55.29]我等待苍老了谁\r\n[01:57.18]红尘醉微醺的岁月\r\n[02:01.18]狼牙月伊人憔悴\r\n[02:05.37]我举杯饮尽了风雪\r\n[02:11.45]是谁打翻前世柜\r\n[02:15.54]惹尘埃是非\r\n[02:17.79]缘字诀几番轮回\r\n[02:22.38]你锁眉哭红颜唤不回\r\n[02:28.01]纵然青史已经成灰\r\n[02:32.30]我爱不灭\r\n[02:34.95]繁华如三千东流水\r\n[02:39.54]我只取一瓢爱了解\r\n[02:43.63]只恋你化身的蝶\r\n[02:49.37]你发如雪凄美了离别\r\n[02:54.01]我焚香感动了谁\r\n[02:58.69]邀明月让回忆皎洁\r\n[03:02.74]爱在月光下完美\r\n[03:05.98]你发如雪纷飞了眼泪\r\n[03:10.52]我等待苍老了谁\r\n[03:15.16]红尘醉微醺的岁月\r\n[03:19.60]我用无悔刻永世爱你的碑\r\n[03:24.42]你发如雪\r\n[03:25.17]凄美了离别\r\n[03:26.47]我焚香感动了谁\r\n[03:28.41]邀明月让回忆皎洁\r\n[03:30.46]爱在月光下完美\r\n[03:32.50]你发如雪纷飞了眼泪\r\n[03:34.55]我等待苍老了谁\r\n[03:36.79]红尘醉微醺的岁月\r\n[03:39.54]你发如雪凄美了离别\r\n[03:43.58]我焚香感动了谁\r\n[03:48.27]邀明月让回忆皎洁\r\n[03:52.41]爱在月光下完美\r\n[03:55.55]你发如雪纷飞了眼泪\r\n[04:00.14]我等待苍老了谁\r\n[04:04.73]红尘醉微醺的岁月\r\n[04:09.32]我用无悔刻永世爱你的碑\r\n[04:14.76]啦儿啦啦儿啦\r\n[04:16.40]啦儿啦儿啦\r\n[04:18.30]啦儿啦啦儿啦\r\n[04:20.45]啦儿啦儿啦\r\n[04:22.64]铜镜映无邪扎马尾\r\n[04:26.38]你若撒野今生我把酒奉陪\r\n[04:30.72]啦儿啦啦儿啦\r\n[04:32.87]啦儿啦儿啦\r\n[04:34.91]啦儿啦啦儿啦\r\n[04:37.06]啦儿啦儿啦\r\n[04:39.15]铜镜映无邪扎马尾\r\n[04:42.79]你若撒野今生我把酒奉陪\r\n
""",
        scrollController: ScrollController(),
      ),
    );
  }
}

///Prints the lyrics on their specified timestamp

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
    final ListenisPlayPage = Provider.of<StateLessdata>(context);
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
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Stack(
                        children: [
                          RotatingCircles(
                            circleList: circleList,
                            circleCenters: [
                              Offset(200, 200),
                              Offset(0, 0),
                              Offset(100, 100),
                              Offset(-100, -100)
                            ],
                          ),
                          BackdropFilter(
                            filter: ui.ImageFilter.blur(
                                sigmaX: 150.0, sigmaY: 150.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Column(
                        children: [
                          Container(
                            width: ScreenSize.width,
                            height: ScreenSize.height * 0.1,
                            decoration: BoxDecoration(
                                // color: Colors.black.withOpacity(0.5),
                                ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("cilick");
                                    context
                                        .read<StateLessdata>()
                                        .ChangeisPlayPage();
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    margin: const EdgeInsets.only(
                                        left: 30, top: 0, bottom: 10),
                                    child: Image.network(testPicUrl),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: const Offset(0, 0),
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "是但求其爱",
                                        style: TextStyle(
                                          fontFamily: "AlimamaDongFangDaKai",
                                          fontSize: 24,
                                          color:
                                              Color.fromARGB(255, 255, 255, 255)
                                                  .withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        "陈奕迅",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 255, 255, 255)
                                                  .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: OverflowBox(
                              child: Container(
                                height: double.infinity,
                                child: OverflowBox(
                                  child: LyricsWidget(
                                    width: 100,
                                    scrollController: ScrollController(),
                                    lyricsdata: """
                                                    [00:03.00]歌曲名 是但求其爱 (2021中国好声音 第7期)\r\n[00:05.00]歌手名 于梓贝\r\n[00:07.00]作词：葛大为  粤语词：小克\r\n[00:10.00]作曲：林家谦\r\n[00:16.80]原唱：陈奕迅\r\n[00:24.64]论尽半生不懂爱\r\n[00:29.58]回头没有心计划未来\r\n[00:34.76]才来独处好好检讨什么叫爱\r\n[00:42.40]你便来\r\n[00:45.44]混乱里结识到你\r\n[00:50.48]浪漫叫一切粉饰同盼待\r\n[00:55.67]某一刹骤觉感情深得可爱\r\n[01:02.10]在倾吐那刻回响\r\n[01:07.39]感情从不是爱\r\n[01:14.02]若爱是但求终身你问\r\n[01:19.36]怕只怕求其终生被困\r\n[01:24.45]你宠爱父母亲\r\n[01:26.99]我为良朋怜悯\r\n[01:29.59]怎都算是个好人\r\n[01:34.83]若爱是但求衷心我问\r\n[01:39.97]要不要求其忠心\r\n[01:45.26]纵双方理念多相同\r\n[01:49.20]却不相融\r\n[01:52.09]莫论配衬\r\n[02:13.94]没料到深深拥抱\r\n[02:19.18]合力擦出了火花和意外\r\n[02:24.37]某一刹幻觉恋情可一可再\r\n[02:30.90]在参透那刻回想\r\n[02:36.19]恋情全不是爱\r\n[02:42.63]若爱是但求终身你问\r\n[02:47.86]怕只怕求其终生被困\r\n[02:53.05]你工作觅满分\r\n[02:55.60]我为前途勤奋\r\n[02:58.19]怎可再另有心神\r\n[03:03.38]若爱是但求衷心我问\r\n[03:08.67]要不要求其忠心\r\n[03:14.01]纵双方理念多相同\r\n[03:17.85]却不相融\r\n[03:20.60]莫论配衬\r\n[03:24.54]若爱是但求安心\r\n[03:29.43]怕只怕求其安稳\r\n[03:44.79]若爱是但求今生抱憾\r\n[03:50.58]要不要求其他生\r\n[03:55.72]看双方各自的本能\r\n[03:59.51]爱的伤痕\r\n[04:02.55]极度配衬\r\n[04:06.69]爱七色五味多纷陈\r\n[04:11.85]更多灰尘\r\n[04:18.49]落入五蕴\r\n[04:23.68]爱是但求其爱\r\n[04:28.82]怕只怕求其""",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
          }
        });
  }
}

class RotatingCircles extends StatefulWidget {
  final List<Widget> circleList;
  final List<Offset> circleCenters; // 新增每个圆形的动画圆心列表

  const RotatingCircles({
    super.key,
    required this.circleList,
    required this.circleCenters,
  });

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
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<AnimatedBuilder> addAnimatedBuilder() {
    List<AnimatedBuilder> animatedBuildersList = [];

    for (var index = 0; index < widget.circleList.length; index++) {
      animatedBuildersList.add(AnimatedBuilder(
        animation: _animation,
        child: widget.circleList[index],
        builder: (context, child) {
          final angle =
              _animation.value + (index * 2 * pi / widget.circleList.length);
          final offset = widget.circleCenters[index].translate(
            100 * cos(angle),
            100 * sin(angle),
          );
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
    return Stack(
      children: [
        Stack(children: addAnimatedBuilder()),
      ],
    );
  }
}

class LyricsWidget extends StatefulWidget {
  final String? lyricsdata;
  final double width;
  final ScrollController scrollController;
  final List<Widget> lyricList = [];
  int CurrentIndex = 0;

  LyricsWidget({
    Key? key,
    required this.lyricsdata,
    required this.width,
    required this.scrollController,
  }) : super(key: key);

  @override
  _LyricsWidgetState createState() => _LyricsWidgetState();
}

class _LyricsWidgetState extends State<LyricsWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<Widget> _items;

  @override
  void initState() {
    super.initState();
    if (widget.lyricsdata != null) {
      Lrc lyricsdataencode = Lrc.parse(widget.lyricsdata!);

      widget.scrollController.addListener(() {
        setState(() {
          widget.CurrentIndex = (widget.scrollController.offset / 80).round();
          print(widget.CurrentIndex);
        });
      });

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        printLyrics(lyricsdataencode);
      });

      _items = List.from(widget.lyricList);
      for (var index = 0; index < lyricsdataencode.lyrics.length; index++) {
        _items.add(Container(
          width: widget.width * 0.9,
          height: 60,
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 25, left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            lyricsdataencode.lyrics[index].lyrics,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 24,
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
              fontFamily: "AlimamaDongFangDaKai",
            ),
          ),
        ));
      }
    }
  }

  void printLyrics(Lrc lrc) async {
    int index = 0;
    await for (LrcStream i in lrc.stream) {
      if (widget.scrollController != null) {
        await widget.scrollController.animateTo(
          index * 60.0,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );

        setState(() {
          if (index == 0) {
            if (index < _items.length) {
              _items[index] = Container(
                width: widget.width * 0.9,
                height: 60,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 25, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  lrc.lyrics[index].lyrics,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 24,
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                    fontFamily: "AlimamaDongFangDaKai",
                  ),
                ),
              );
            }
          } else {
            if (index - 1 < _items.length) {
              _items[index - 1] = Container(
                width: widget.width * 0.9,
                height: 60,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 25, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  lrc.lyrics[index - 1].lyrics,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 24,
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                    fontFamily: "AlimamaDongFangDaKai",
                  ),
                ),
              );
            }
          }
          if (index < _items.length) {
            _items[index] = Container(
              width: widget.width * 0.9,
              height: 60,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 25, left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                lrc.lyrics[index].lyrics,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 24,
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                  fontFamily: "AlimamaDongFangDaKai",
                ),
              ),
            );
          }
        });

        index += 1;
        print("have skipped $index");
      } else {
        print('Currentlyrics 或 scrollController 为 null');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      child: AnimatedList(
        key: _listKey,
        controller: widget.scrollController,
        initialItemCount: _items.length,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return AnimatedOpacity(
            opacity: index == widget.CurrentIndex ? 1.0 : 1.0,
            duration: Duration(milliseconds: 500),
            child: _items[index],
          );
        },
      ),
    );
  }
}
