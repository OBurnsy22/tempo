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
          isPlaying = false;
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
    return controller.isDismissed
        ? '${controller.duration.inHours}:${(controller.duration.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void notify() {
    if(countText == '0:00:00'){
      FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade700,
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.deepOrange[300],
          )
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
                      backgroundColor: Colors.white,
                      value: progress,
                      strokeWidth: 6,
                      color: Colors.deepOrange[300],
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
                              color: Colors.white,
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
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: ElevatedButton(
                      child: Icon(
                        isPlaying == true ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange[300],
                      ),
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
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        child: Icon(
                          Icons.stop,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange[300]
                        ),
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