import 'package:audioplayers/src/source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/documents/audio_provider.dart';
import '../my_text.dart';

class AudioDialog extends StatefulWidget {
  final String audioPath;
  final String? fileName;
  final int audioId;

  const AudioDialog(
      {Key? key,
      required this.audioPath,
      required this.fileName,
      required this.audioId})
      : super(key: key);

  @override
  State<AudioDialog> createState() => _AudioDialogState();
}

class _AudioDialogState extends State<AudioDialog> {
  AudioProvider audioProvider = AudioProvider();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AudioProvider>(context, listen: false)
          .initOperation(widget.audioPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 100, top: 100, right: 250, left: 250),
      child: AlertDialog(
        elevation: 20,
        content: contentBody(context),
      ),
    );
  }

  Widget contentBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        imageBody(),
        const SizedBox(
          height: 20,
        ),
        titleBody(widget.fileName),
        const SizedBox(
          height: 20,
        ),
        audioBarBody(context),
        const SizedBox(
          height: 20,
        ),
        buttonBodyBody(context)
      ],
    );
  }

  Widget titleBody(String? title) {
    return myText(title ?? "", color: Colors.black54, size: 22);
  }

  Widget audioBarBody(BuildContext context) {
    double duration =
        Provider.of<AudioProvider>(context).duration.inSeconds.toDouble();
    double position =
        Provider.of<AudioProvider>(context).position.inSeconds.toDouble();
    return Column(
      children: [
        Slider(
            min: 0,
            max: duration,
            value: position,
            onChanged: (value) async {
              Provider.of<AudioProvider>(context, listen: false)
                  .changeAudioValue(value.toInt());
            }),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatTime(position.toInt())),
            Text(formatTime(duration.toInt()))
          ],
        )
      ],
    );
  }

  Widget buttonBodyBody(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).primaryColor),
        child: IconButton(
            onPressed: () async {
              if (Provider.of<AudioProvider>(context, listen: false)
                  .isPlaying) {
                await Provider.of<AudioProvider>(context, listen: false)
                    .pauseAudio();
              } else {
                Provider.of<AudioProvider>(context, listen: false)
                    .audioPlayer
                    .play(DeviceFileSource(widget.audioPath));
              }
            },
            icon: Icon(
              Provider.of<AudioProvider>(context).isPlaying
                  ? Icons.stop
                  : Icons.play_arrow,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget imageBody() {
    return Image.asset(
      "assets/images/aduio.jpg",
      height: 200,
      width: 200,
    );
  }

  formatTime(time) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
