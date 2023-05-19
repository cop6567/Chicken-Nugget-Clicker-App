import 'package:flutter/material.dart';

void main() => runApp(ChickenNuggetClickerApp());

class ChickenNuggetClickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(199,144,83, 100),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5.0, color: Colors.lightBlue.shade600),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, left: 15),
                    child: Row(

                      children: [
                        TextButton(onPressed: () {}, child: Icon(
                            Icons.ios_share_outlined,
                        size: 40,
                        color: Colors.black,))
                      ],
                    ),
                  ),
                ),


              ),
            ),
            Container(
              color: Colors.brown,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      child: Icon(
                        Icons.ads_click_rounded,
                        size: 50,
                      ),
                      color: Colors.brown,
                      height: 40,
                    ),
                  ),
                  Expanded(
                    child: Container(

                      child: Icon(
                        Icons.leaderboard_outlined,
                        size: 40
                      ),
                      color: Colors.brown,
                      height: 60,
                    ),
                  ),
                  Expanded(

                    child: Container(

                      child: Icon(
                          Icons.settings_outlined,
                          size: 40
                      ),
                      color: Colors.brown,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Square extends StatelessWidget {
  final double size;
  final Color color;

  Square({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: color,
    );
  }
}
