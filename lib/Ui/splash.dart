import 'package:flutter/material.dart';

import 'home.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {super.initState();
    Future.delayed(const  Duration(seconds: 5),(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage()));    }
    // TODO: implement initState

    );}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center (
         child: Text("E-Store" , style: TextStyle(
           fontWeight: FontWeight.bold,
           fontSize: 25,
           color: Color(0xff0E697C),
         ),),
      ),
    );
  }
}
