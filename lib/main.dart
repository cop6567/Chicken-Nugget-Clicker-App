import 'package:flutter/material.dart';
import 'settings_page.dart';

void main() => runApp(const ChickenNuggetClickerApp());

class ChickenNuggetClickerApp extends StatefulWidget {
  const ChickenNuggetClickerApp({Key? key}) : super(key: key);

  @override
  _ChickenNuggetClickerAppState createState() => _ChickenNuggetClickerAppState();
}

class _ChickenNuggetClickerAppState extends State<ChickenNuggetClickerApp> {
  int counter = 0;
  bool isPopped = false;
  bool isSettingsPageActive = false;

  void _handleButtonClick() {
    setState(() {
      counter++;
      isPopped = true;
    });

    Future.delayed(const Duration(milliseconds: 30), () {
      setState(() {
        isPopped = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Click!'),
          leadingWidth: 90,
          toolbarHeight: 60,
          leading: Container(
            margin: const EdgeInsets.only(left: 2),
            child: IconButton(
              icon: const Icon(Icons.ios_share_outlined, color: Colors.black, size: 40,),
              onPressed: () {
                // Implement your share button logic here
              },
            ),
          ),
          backgroundColor: Colors.brown,
        ),
        backgroundColor: const Color.fromRGBO(199, 144, 83, 1),
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 160.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _handleButtonClick,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 30),
                            width: isPopped ? 280 : 300,
                            height: isPopped ? 280 : 300,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Image.asset(
                                'imgs/nugget.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isPopped ? 'Nuggets: $counter' : 'Nuggets: $counter',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.brown,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 60,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<CircleBorder>(
                                    const CircleBorder(),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Icon(
                                  Icons.ads_click_outlined,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.brown,
                              height: 60,
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<CircleBorder>(
                                    const CircleBorder(),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.leaderboard_outlined,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.brown,
                              height: 60,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isSettingsPageActive = true;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => const SettingsPage(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<CircleBorder>(
                                    const CircleBorder(
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  Icons.settings_outlined,
                                  size: 40,
                                  color: isSettingsPageActive ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
