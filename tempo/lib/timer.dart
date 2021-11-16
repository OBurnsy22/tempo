import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';


class timer extends StatefulWidget {
  @override
  timerState createState() => timerState();
}

class timerState extends State<timer> with TickerProviderStateMixin {
  AnimationController controller;
  bool isPlaying = false;
  double progress = 1.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 60));

    controller.addListener(() {
      notify();
      if(controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
        });
      }
    });
  }

  @override dispose() {
    controller.dispose();
    super.dispose();
  }

  String get countText {
    Duration count = controller.duration * controller.value;
    return controller.isDismissed ?
    '${controller.duration.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}' :
    '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void notify() {
    if(countText == '0:00:00'){
      FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
        ),
      body: Column(
        children: [
          Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade300,
                      value: progress,
                      strokeWidth: 6,
                    )
                  ),
                  GestureDetector(
                      onTap: () {
                        if (controller.isDismissed) {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                  height: 300,
                                  child: CupertinoTimerPicker(
                                      initialTimerDuration: controller.duration,
                                      onTimerDurationChanged: (time) {
                                        setState(() {
                                          controller.duration = time;
                                        });
                                      }
                                  )
                              )
                          );
                        }
                      },
                      child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) => Text(
                            countText,
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      )
                  )
                 ]
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:
            10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    if(controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value
                      );
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: ElevatedButton(
                    child: Icon(
                      isPlaying == true ? Icons.pause : Icons.play_arrow,
                    )
                  )
                ),
                GestureDetector(
                    onTap: (){
                      controller.reset();
                      setState(() {
                        isPlaying = false;
                      });
                    },
                    child: ElevatedButton(
                        child: Icon(
                          Icons.stop,
                        )
                    )
                )
              ],
            )
          )
        ],
      )
    );
  }
}