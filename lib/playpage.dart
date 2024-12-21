import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'dart:ui' as ui;
import 'package:palette_generator/palette_generator.dart';
import './main.dart';

class Playpage extends StatefulWidget {
  const Playpage({ Key? key }) : super(key: key);

  @override
  _PlaypageState createState() => _PlaypageState();
}

class _PlaypageState extends State<Playpage> {
  @override
  Widget PlayerPage(ui.Size screenSize) {
  return Stack(
    children: <Widget>[
      Positioned(
        left: 100,
        top: 100,
        child: Transform.scale(
          scale: 3,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Image.network(
                testPicUrl,
                width: screenSize.width,
                height: screenSize.height,
                fit: BoxFit.fill,
              );
            },
          ),
        ),
      ),
      BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
        child: Container(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      Positioned(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(testPicUrl)),
                  borderRadius:
                      BorderRadius.circular(screenSize.width * 0.6 / 20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(5, 5),
                      blurRadius: 16.0,
                      spreadRadius: 5.0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                width: screenSize.width * 0.6,
                height: screenSize.width * 0.6,
                clipBehavior: Clip.antiAlias,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.2,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "这是标题",
                        style: TextStyle(
                          fontFamily: "AlimamaDongFangDaKai",
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "这是歌手",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton.filled(
                        onPressed: () {
                          debugPrint("收藏");
                        },
                        icon: const Icon(
                          Icons.star_outline_rounded,
                        ),
                        color: Colors.white.withOpacity(0.5),
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Colors.white.withOpacity(0.1))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton.filled(
                        onPressed: () {
                          debugPrint("更多");
                        },
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.white.withOpacity(0.5),
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Colors.white.withOpacity(0.1))),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenSize.width * 0.2,
                  ),
                ],
              ),
              const SizedBox(
                // TODO:进度条实现
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.2,
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      debugPrint("上一首");
                    },
                    icon: const SvgIcon(
                        icon: SvgIconData("assets/player-last.svg")),
                    color: Colors.white,
                    iconSize: screenSize.width / 10 * 1.2,
                  ),
                  const Spacer(),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        if (isPlaying == true) {
                          isPlaying = false;
                        } else {
                          isPlaying = true;
                        }
                      });
                      debugPrint(isPlaying == true ? "播放" : "暂停");
                    },
                    icon: SvgIcon(
                        icon: isPlaying == true
                            ? const SvgIconData("assets/pause.fill.svg")
                            : const SvgIconData("assets/play.svg")),
                    color: Colors.white,
                    iconSize: screenSize.width / 10 * 1.2,
                  ),
                  const Spacer(),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      debugPrint("下一首");
                    },
                    icon: const SvgIcon(
                        icon: SvgIconData("assets/player-next.svg")),
                    color: Colors.white,
                    iconSize: screenSize.width / 10 * 1.2,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.2,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.2,
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    iconSize: screenSize.width / 15,
                    color: Colors.white,
                    onPressed: () {
                      debugPrint("评论");
                    },
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white.withOpacity(0.25),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (currentPlayWay == PlayWay.repeat) {
                                currentPlayWay = PlayWay.shuffle;
                              } else {
                                currentPlayWay = PlayWay.repeat;
                              }
                            });
                            debugPrint(currentPlayWay == PlayWay.repeat
                                ? "顺序播放"
                                : "随机播放");
                          },
                          icon: SvgIcon(
                              icon: currentPlayWay == PlayWay.repeat
                                  ? const SvgIconData(
                                      "assets/player-repeat.svg")
                                  : const SvgIconData(
                                      "assets/player-shuffle.svg")),
                          color: Colors.white.withOpacity(0.4),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          color: const Color.fromARGB(100, 255, 255, 255),
                          width: 1,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () {
                            debugPrint("下载");
                          },
                          icon: const Icon(Icons.download),
                          iconSize: 20,
                          color: Colors.white.withOpacity(0.4),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.playlist_play),
                    iconSize: screenSize.width / 15,
                    color: Colors.white,
                    onPressed: () {
                      debugPrint("播放列表");
                    },
                  ),
                  SizedBox(
                    width: screenSize.width * 0.2,
                  ),
                  const lyrcisPage(),
                ],
              ),
            ],
          ),
        ),
      )
    ],
  );
}

  Widget build(BuildContext context) {
    return PlayerPage(MediaQuery.sizeOf(context));
  }
}

