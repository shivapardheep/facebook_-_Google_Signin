import 'package:facebook_login/pages/authScreen.dart';
import 'package:facebook_login/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  facebookUserCheck() async {
    var fbData;
    var fbAuth = await FacebookAuth.instance;
    var data = await fbAuth.getUserData().then((value) {
      setState(() {
        fbData = value;
      });
    });
    if (fbAuth.accessToken != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => HomePage(
                    Email: fbData['email'],
                    userName: fbData["name"],
                    profileImage: fbData['picture']['data']['url'],
                  )),
          (route) => false);
    } else {
      setState(() {
        googleUserCheck();
      });
    }
  }

  googleUserCheck() async {
    var instance = await _googleSignIn.signInSilently();
    if (instance != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => HomePage(
                    Email: _googleSignIn.currentUser!.email,
                    userName: _googleSignIn.currentUser!.displayName.toString(),
                    profileImage:
                        _googleSignIn.currentUser!.photoUrl.toString(),
                  )),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => AuthScreen()), (route) => false);
    }
  }

  @override
  void initState() {
    facebookUserCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
