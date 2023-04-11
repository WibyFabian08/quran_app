import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/models/surah.dart';

import 'package:audioplayers/audioplayers.dart';

// ignore: must_be_immutable
class AudioPlayerWidget extends StatefulWidget {
  AudioPlayerWidget({super.key, required this.ayah});
  Ayah ayah;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer player = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
  }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      if (!mounted) {
        return;
      }
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      if (!mounted) {
        return;
      }
      setState(() {
        duration = newDuration;
      });
    });

    player.onAudioPositionChanged.listen((newPosition) {
      if (!mounted) {
        return;
      }
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();

    // setState(() {
    //   position = Duration.zero;
    //   duration = Duration.zero;
    //   isPlaying = false;
    // });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Ayat No : ${widget.ayah.number.inSurah}",
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600)),
      Slider(
        activeColor: Colors.white,
        inactiveColor: Colors.white,
        min: 0,
        max: duration.inSeconds.toDouble(),
        value: position.inSeconds.toDouble(),
        onChanged: (value) async {
          setState(() {
            if (!mounted) {
              return;
            }
            // position = Duration(seconds: value.toInt());
          });
          final localPosition = Duration(seconds: value.toInt());

          await player.seek(localPosition);

          await player.resume();
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatTime(position),
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                formatTime(duration),
                style: const TextStyle(color: Colors.white),
              ),
            ]),
      ),
      CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          color: Colors.white,
          onPressed: () async {
            if (isPlaying) {
              await player.pause();
            } else {
              String url = widget.ayah.audio.alafasy;
              await player.play(url);
            }
          },
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: primary,
          ),
        ),
      )
    ]);
  }
}
