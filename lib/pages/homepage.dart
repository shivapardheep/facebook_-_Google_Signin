import 'package:facebook_login/pages/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  final String profileImage;
  final String userName;
  final String Email;

  const HomePage(
      {super.key,
      required this.profileImage,
      required this.userName,
      required this.Email});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _focebookLogout() async {
    await FacebookAuth.instance.logOut().then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => AuthScreen()), (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: NetworkImage(widget.profileImage)),
            Text("${widget.userName}"),
            Text("${widget.Email}"),
            const SizedBox(height: 50),
            IconButton(
                onPressed: () {
                  // _focebookLogout();
                  GoogleSignIn().signOut().then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => AuthScreen()),
                        (route) => false);
                  });
                },
                icon: const Icon(
                  Icons.logout,
                  size: 40,
                )),
          ],
        ),
      ),
    );
  }
}
