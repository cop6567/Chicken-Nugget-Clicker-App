import 'package:flutter/material.dart';
import 'main.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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

              const SizedBox(height:150),

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

              SizedBox(height: 10,),

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

              const SizedBox(height: 12),

              const Text('Psst! Login forms coming soon!', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 10),),


              const SizedBox(height: 300,),

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

              const SizedBox(height: 10,),

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
      ),
    );
  }
}