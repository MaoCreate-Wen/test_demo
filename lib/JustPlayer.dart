import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> TestPlayer() async {
  final player = AudioPlayer();
  final duration = player.setUrl(
      "http://freetyst.nf.migu.cn/public/ringmaker01/n17/2017/07/%E6%97%A0%E6%8D%9F/2009%E5%B9%B406%E6%9C%8826%E6%97%A5%E5%8D%9A%E5%B0%94%E6%99%AE%E6%96%AF/flac/%E5%85%B0%E4%BA%AD%E5%BA%8F-%E5%91%A8%E6%9D%B0%E4%BC%A6.flac?Key=726bcb61f6111926&channelid=00&msisdn=ef87d00d4b874694b86d2a18382d6fbb&CI=600547020062600902000006889030&F=011002");
  player.setVolume(0.7);
  player.play();
  player.setLoopMode(LoopMode.all);
}

class MusicPlayer {
  AudioPlayer? player;
  String? Url;
  ConcatenatingAudioSource? PlayList;

  void SetUrl() {
    player?.setAudioSource(AudioSource.uri(
      Uri.parse(Url!),
      tag: MediaItem(
        id: '1',
        album: "Science Friday",
        title: "A Salute To Head-Scratching Science",
      ),
    ));
  }

  void PlayMusic() {
    this.player?.play();
  }

  void SetVolume(double VolumeValue) {
    this.player?.setVolume(VolumeValue);
  }

  void SetLoopModel(LoopMode Model) {
    this.player?.setLoopMode(Model);
  }

  void NextSong() {
    this.player?.seekToNext();
  }

  void PreviousSong() {
    this.player?.seekToPrevious();
  }

  Future<void> PlaySeekSongs(int Index) async {
    await this.player?.seek(Duration.zero, index: Index);
  }

  void SetPlayList(List<AudioSource> PlayListSource) {
    PlayList = ConcatenatingAudioSource(
        useLazyPreparation: true, children: PlayListSource);
    this.player?.setAudioSource(PlayList!,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  Future<void> InsertSongList(int Index, AudioSource SongInfo) async {
    await PlayList?.insert(Index, SongInfo);
  }
}
