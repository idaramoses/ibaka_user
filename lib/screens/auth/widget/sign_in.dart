import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onproperty/components/social_media_button.dart';
import 'package:onproperty/utils/colorscheme.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  String _email, _password;
  bool isLoading = false;
  bool ispaswordvisible = false;

  login() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        try {
          await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
          await Navigator.pushReplacementNamed(context, "/");
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.message,
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
          ));
          // setState(() {
          //   isLoading = false;
          // });
          print(e);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xfff3f3f4),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: TextFormField(
                      autocorrect: false,
                      cursorColor: primaryColor,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.only(left: 16.0),
                        hintText: 'Enter Email Address',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Color(0xfff5f6f6),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide:
                              BorderSide(color: primaryColor.withOpacity(0.4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                      onSaved: (input) => _email = input),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: TextFormField(
                    validator: validatepassword,
                    autocorrect: false,
                    obscureText: ispaswordvisible ? true : false,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      contentPadding: EdgeInsets.only(left: 16.0),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              ispaswordvisible = true;
                            });
                          },
                          child: Icon(Icons.visibility)),
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Color(0xfff5f6f6),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide:
                            BorderSide(color: primaryColor.withOpacity(0.4)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    onSaved: (input) => _password = input,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'ForgotPassword');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                /* ..........................Sign In Now Button....................*/
                GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: primaryColor),
                    child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : Text(
                                'Signup now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                  child: Text(
                    'or Continue With',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                /*  ..........................Row of Two Containers.........................*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    socialMediaButton(
                        img: 'assets/icons/google.png',
                        callback: () {
                          googleSignIn();
                        },
                        text: 'Google',
                        color: Colors.grey[200]),
                    socialMediaButton(
                        img: 'assets/icons/fb.png',
                        callback: () {},
                        text: 'Facebook',
                        color: Colors.grey[200]),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        )),
      ),
    );
  }

  String validateEmail(String value) {
    if (value.trim().length < 1) return "Email can't be empty";
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.trim())) return "Invalid email address";
    return null;
  }

  String validatepassword(String value) {
    if (value.trim().length < 1)
      return "Password must be more than 6 characters";
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
        .hasMatch(value.trim()))
      return "Password must contain capital,small letters and numbers";
    return null;
  }
}
