
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MaterialApp(home: isLoggedIn ? const ChickenNuggetClickerApp() : const SignIn(),
  ));
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
              icon: const Icon(Icons.login_outlined, color: Colors.black, size: 30,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignIn()),
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
                                'assets/nugget.png',
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

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;


  @override
  void initState() {
    super.initState();
    _email = '';
    _password = '';
  }

  void _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ChickenNuggetClickerApp()),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign-in Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _goToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/nugget.png'),
                const SizedBox(height: 20),
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => _email = value.trim(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) => _password = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _signInWithEmailAndPassword,
                  child: const Row(
                    children: [
                      SizedBox(width: 160),
                      Text('Sign in'),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _goToSignUp,
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// SIGN UP PAGE BELOW




class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isEmailVerified = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerificationStatus();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void checkEmailVerificationStatus() async {
    final User? currentUser = _auth.currentUser;
    await currentUser?.reload();
    if (currentUser != null && currentUser.emailVerified) {
      setState(() {
        isEmailVerified = true;
      });
      _timer.cancel();
      // Navigate to success page or perform any other actions
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SuccessPage()),
      );
    }
  }

  Future<void> _signUpWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        await userCredential.user!.sendEmailVerification();

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Email Verification'),
              content: Text(
                'A verification email has been sent to your email address. '
                    'Please click the verification link to proceed.',
              ),
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign-up Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/nugget.png'),
                const SizedBox(height: 20),
                const Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => _email = value.trim(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) => _password = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _signUpWithEmailAndPassword,
                  child: const Row(
                    children: [
                      SizedBox(width: 160),
                      Text('Sign up'),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                const Text(
                  'Or Continue with...',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 20,
                          ),
                          Icon(
                            Icons.apple,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 20,
                          ),
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.black,
                            size: 40,
                          ),
                          SizedBox(width: 20)
                        ],
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 20,
                          ),
                          Icon(
                            Icons.facebook,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 100),
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignIn(),
                          ),
                        );
                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Success!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            currentUser!.emailVerified
                ? const Text(
              'Sign up successful!',
              style: TextStyle(fontSize: 24),
            )
                : const Text(
              'Sign up successful!\n'
                  'Please verify your email to proceed.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignIn(),
                  ),
                );
              },
              child: const Text('Go to Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
