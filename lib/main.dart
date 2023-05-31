
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChickenNuggetClickerApp());
}

class ChickenNuggetClickerApp extends StatefulWidget {
  const ChickenNuggetClickerApp({Key? key}) : super(key: key);

  @override
  _ChickenNuggetClickerAppState createState() => _ChickenNuggetClickerAppState();
}

class _ChickenNuggetClickerAppState extends State<ChickenNuggetClickerApp> {
  int counter = 0;
  bool isPopped = false;
  bool isSettingsPageActive = false;
  late User? _user;

  @override
  void initState() {
    super.initState();
    _initAuth();
  }

  Future<void> _initAuth() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      setState(() {
        _user = user;
      });

      if (_user != null) {
        // Load user's clicks from Firestore
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .collection('clicks')
            .get();

        setState(() {
          counter = docSnapshot.docs.length;
        });
      }
    });
  }


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

    if (_user != null) {
      // Log click to Firestore
      FirebaseFirestore.instance.collection('users').doc(_user!.uid).collection('clicks').add({
        'timestamp': DateTime.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text('Click!'),
          leadingWidth: 90,
          toolbarHeight: 60,
          leading: Container(
            margin: const EdgeInsets.only(left: 2),
            child: IconButton(
              icon: const Icon(Icons.ios_share_outlined, color: Colors.black, size: 40,),
              onPressed: () {},
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.login_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );

              }
            ),
          ],
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
                                    MaterialPageRoute(
                                      builder: (_) => const SettingsPage(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<CircleBorder>(
                                    const CircleBorder(),
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

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow
      ,
      appBar: AppBar(
        title: const Text('Sign in'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            const Text("Let's Get You Started", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,),),
            const SizedBox(height: 50,),


            Image.asset('assets/nugget.png'),

            const SizedBox(height: 40,),


            Container(

              color: Colors.black,
              width:  360,
              child: TextButton(onPressed:  () {},
                  child: Row(
                    children: const [
                      Icon(Icons.apple, color: Colors.white,),
                      SizedBox(width: 80),
                      Text('Sign in with Apple', style: TextStyle(color: Colors.white),),

                    ],
                  ) ),
            ),
            const SizedBox(height: 10,),

            Container(

              color: Colors.white,
              width: 360,
              child: TextButton(onPressed:  () {},
                  child: Row(
                    children: const [
                      Icon(FontAwesomeIcons.google, color: Colors.black,),
                      SizedBox(width: 80),
                      Text('Sign in with Google', style: TextStyle(color: Colors.black),),
                    ],
                  ) ),
            ),

            const SizedBox(height: 10,),

            Container(

              color: Colors.blueAccent,
              width: 360,
              child: TextButton(onPressed:  () {},
                  child: Row(
                    children: const [
                      Icon(FontAwesomeIcons.facebook, color: Colors.white,),
                      SizedBox(width: 80),
                      Text('Sign in with Facebook', style: TextStyle(color: Colors.white),),

                    ],
                  ) ),
            ),

            const SizedBox(height: 10,),

            const Text('Psst! Login forms coming soon!', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 10),),


            const SizedBox(height: 120,),

            Container(

              color: Colors.white,
              width: 200,
              child: TextButton(onPressed:  () {},
                  child: Row(
                    children: const [
                      Icon(FontAwesomeIcons.github, color: Colors.black,),
                      SizedBox(width: 20),
                      Text('Support the project', style: TextStyle(color: Colors.black),),

                    ],
                  ) ),
            ),

            SizedBox(height: 10,),


            Container(

              color: Colors.pink,
              width: 200,
              child: TextButton(onPressed:  () {},
                  child: Row(
                    children: const [
                      Icon(Icons.coffee, color: Colors.black,),
                      SizedBox(width: 20),
                      Text('Buy me a coffee', style: TextStyle(color: Colors.white),),

                    ],
                  ) ),
            ),
          ],
        ),
      ),
    );
  }
}

