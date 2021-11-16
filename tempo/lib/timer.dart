import 'package:flutter/material.dart';

class timer extends StatefulWidget {
  @override
  timerState createState() => timerState();
}

class timerState extends State<timer> with TickerProviderStateMixin {
  AnimationController controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 60));
  }

  @override dispose() {
    controller.dispose();
    super.dispose();
  }

  String get countText {
    Duration count = controller.duration * controller.value;
    return '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
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
            child: Center(
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