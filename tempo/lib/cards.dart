import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class cardsHome extends StatefulWidget {

  @override
  cardsHomeState createState() => cardsHomeState();
}

class cardsHomeState extends State<cardsHome> with AutomaticKeepAliveClientMixin<cardsHome> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.green,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 0.07,
                  child: Container(
                    color: Colors.yellow,
                    child: Row(
                      children: <Widget> [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.create_new_folder_outlined,
                            size: 40,
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.add_outlined,
                              size: 40,
                            )
                        )
                      ],
                    ),
                  )
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}