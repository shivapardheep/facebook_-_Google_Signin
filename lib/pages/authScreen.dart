import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'homepage.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var userdata;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _fbLoginFun() async {
    await FacebookAuth.instance.login().then((value) {
      FacebookAuth.instance.getUserData().then((data) {
        // FacebookAuth.instance.
        setState(() {
          userdata = data;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => HomePage(
                      Email: userdata['email'],
                      userName: userdata["name"],
                      profileImage: userdata['picture']['data']['url'],
                    )),
            (route) => false);
      });
    });
  }

  _google_login() async {
    var instance = await _googleSignIn.signIn();
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
    }

    print("${instance!.photoUrl.toString()}");
  }

  _check_google_loged_user() async {
    // var instance = await _googleSignIn.currentUser;
    await _googleSignIn.signIn();
    print("++++++++++++++${_googleSignIn.currentUser!.email.toString()}");
  }

  @override
  void initState() {
    // _check_google_loged_user();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _fbLoginFun();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  "Facebook login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // IconButton(
              //     onPressed: () {
              //       print(userdata);
              //       var instance =
              //           FacebookLogin().getProfileImageUrl(width: 100);
              //       print("access token is : $instance");
              //       print(FacebookLoginStatus.success);
              //     },
              //     icon: const Icon(
              //       Icons.send,
              //       size: 40,
              //     )),
              ElevatedButton(
                onPressed: () {
                  _google_login();
                },
                // color: Colors.green,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  "Google Signin",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // IconButton(
              //     onPressed: () {
              //       _check_google_loged_user();
              //       // print(userdata);
              //       // var instance =
              //       //     FacebookLogin().getProfileImageUrl(width: 100);
              //       // print("google data is  : ${_account!.email}");
              //       // print(FacebookLoginStatus.success);
              //     },
              //     icon: const Icon(
              //       Icons.send,
              //       size: 40,
              //     )),
              // IconButton(
              //     onPressed: () {
              //       _googleSignIn.signOut();
              //     },
              //     icon: const Icon(
              //       Icons.logout,
              //       size: 40,
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
