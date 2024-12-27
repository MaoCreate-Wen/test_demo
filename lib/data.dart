import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:wenlistener/song.dart';

class StateLessdata with ChangeNotifier {
  List<Map<String, dynamic>>? selectResult = [];
  List<AudioSource> PlayListSource = [];
  List<Map<String, String>> searchSongs = [];
  Map<String, String> AddSongs = {
    "Name": "",
    "Singer": "",
    "PlayUrl": "",
    "ImageUrl": "",
  };
  bool isPlayPage = true;
  bool isPlaying = true;
  late Song PlayingSong;
  void ChangeisPlayPage() {
    isPlayPage = !isPlayPage;
    notifyListeners();
  }

  Future<List<Map<String, String>>> GetSearch(
    String SearchContent,
    String SearchPageNo,
    String SearchPage,
  ) async {
    var url = Uri.https("m.music.migu.cn", "migumusic/h5/search/all",
        {"text": SearchContent, "pageNo": SearchPageNo, "page": SearchPage});
    print(url);
    var res = await http.get(url, headers: {
      "Referer": "https://m.music.migu.cn/v4/",
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36",
      "By": "3c0effb5be907dd7fc209a9001a18713"
    });
    var searhResult = jsonDecode(utf8.decode(res.bodyBytes));
    var listLength = searhResult["data"]["songsData"]["items"].length;
    searchSongs = [];
    for (var i = 0; i < listLength; i++) {
      searchSongs.add({
        "Name": searhResult["data"]["songsData"]["items"][i]["name"],
        "Singer": searhResult["data"]["songsData"]["items"][i]["singers"][0]
            ["name"],
        "CopyrightId": searhResult["data"]["songsData"]["items"][i]
            ["copyrightId"],
      });
    }
    return await searchSongs;
  }

  Future<void> GetSongInfo(String songId) async {
    var timestemp = DateTime.now().microsecondsSinceEpoch / 1000;
    var url =
        Uri.https("app.c.nf.migu.cn", "MIGUM2.0/strategy/listen-url/v2.4", {
      "albumId": "1000012211",
      "lowerQualityContentId": "600902000009524270", //productid
      "netType": "01",
      "resourceType": "2",
      "songId": songId,
      "toneFlag": "PQ"
    });
    var headers = {
      "gsm": "0",
      "randomsessionkey": "000000",
      "mgm-user-agent": "M2011K2C",
      "User-Agent":
          "Mozilla/5.0 (Linux; U; Android 13; zh-cn; M2011K2C Build/TKQ1.220829.002) AppleWebKit/533.1 (KHTML, like Gecko) Version/5.0 Mobile Safari/533.1",
      "channel": "0146921",
      "language": "Chinese",
      "ua": "Android_migu",
      "mode": "android",
      "brand": "Xiaomi",
      "recommendstatus": "1",
      "version": "7.32.0",
      "mgm-Network-type": "04",
      "mgm-network-operators": "02",
      "mgm-Network-standard": "01",
      "Accept-Language": "zh-CN,zh;q=0.8",
      "OAID": "1ac40da59c1bba7e",
      "platform": "M2011K2C",
      "userLevel": "0",
      "osVersion": "Android 13",
      "verify": "verify",
      "logId": "1693228561702",
      "os": "Android 13",
      "Host": "app.c.nf.migu.cn",
      "Accept-Encoding": "gzip",
      "signVersion": "V004",
      "sign": "16467982D356C8D2B530506D217D2AED",
      "aversionid":
          "DF948B8F98A6A68F669888A6D07C99A593988ABC999DA388639A84A1897E9D6EC598B8BD8ED3A58F63C6BCA2BAACCD769BDFD0D391A9D88E97968ED0887D9DA4C99A898DDDECEE896B93859E8A8195729394828891ECA38E6B94899F8C7E9E779B9A87",
      "timestamp": timestemp.toString()
    };
    var res = await http.get(url, headers: headers);
    var rescontent = jsonDecode(utf8.decode(res.bodyBytes));
    this.AddSongs["Name"] = rescontent["data"]["song"]["songName"];
    this.AddSongs["Singer"] =
        rescontent["data"]["song"]["singerList"][0]["name"];
    this.AddSongs["PlayUrl"] = rescontent["data"]["url"];
    this.AddSongs["imageUrl"] = rescontent["data"]["song"]["img1"];
    print(AddSongs);
  }
}
