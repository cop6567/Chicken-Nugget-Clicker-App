import 'package:flutter/material.dart';
import 'main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Widget buildStyledRow(String text, IconData icon) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.brown,
            width: 2,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(icon),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(199, 144, 83, 1),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
        leading: Container(
          margin: const EdgeInsets.only(left: 2),
          child: IconButton(
            icon: const Icon(Icons.ios_share_outlined, color: Colors.black, size: 40,),
            onPressed: () {
              // Implement your share button logic here
            },
          ),
        ),
        toolbarHeight: 60,
        leadingWidth: 90,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Column(
            children: const [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('path_to_profile_picture'),
              ),
              SizedBox(height: 10),
              Text(
                'John Doe',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  buildStyledRow('Theme', Icons.brush_outlined),
                  buildStyledRow('Version', Icons.view_week_rounded),
                  buildStyledRow('Row 3', Icons.brush_outlined),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.brown,
              padding: const EdgeInsets.all(10),
              child: Row(
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const ChickenNuggetClickerApp(),
                              transitionDuration: Duration.zero,
                            ),
                          );
                        },
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
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder(),
                          ),
                        ),
                        child: const Icon(
                          Icons.settings_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
