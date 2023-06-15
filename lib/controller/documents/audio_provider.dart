import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioProvider with ChangeNotifier{
  int currentAudioId=999;
  AudioPlayer audioPlayer=AudioPlayer();
  bool isPlaying=false;
  Duration duration =Duration.zero;
  Duration position =Duration.zero;

  changeAudioValue(int value)async{
    final position=Duration(seconds: value);
    await audioPlayer.seek(position);
    notifyListeners();
  }

   initOperation(String audioPath){
     audioPlayer.play(DeviceFileSource(audioPath) );


    audioPlayer.onPlayerStateChanged.listen((event) {
      isPlaying= event==PlayerState.playing;
      notifyListeners();
    });

    audioPlayer.onDurationChanged.listen((event) {
      duration=event;
      notifyListeners();

    });

    audioPlayer.onPositionChanged.listen((event) {
      position=event;
      notifyListeners();

    });
   }

  pauseAudio(){
    isPlaying=false;
     audioPlayer.pause();
    notifyListeners();
  }

  disposeAudio()async{
    isPlaying=false;
     duration =Duration.zero;
     position =Duration.zero;
     await audioPlayer.dispose();
  }
}