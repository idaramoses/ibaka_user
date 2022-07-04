import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onproperty/components/social_media_button.dart';
import 'package:onproperty/utils/colorscheme.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
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
        updateuserprofile();
        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  String _name, _email, _password;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xfff3f3f4),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    this.checkAuthentication();
  }

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  void updateuserprofile() async {
    var ref = FirebaseFirestore.instance
        .collection("users")
        .doc('${FirebaseAuth.instance.currentUser.uid},');
    ref.set({
      "user_id": FirebaseAuth.instance.currentUser.uid,
      "user_email": FirebaseAuth.instance.currentUser.email,
      'user_name': FirebaseAuth.instance.currentUser.displayName,
      'isadmin': false,
    }).whenComplete(() => {
          _firebaseMessaging.getToken().then((token) {
            print(token);
            ref.update({'token': token.toString()});
          })
        });
  }

  signUp() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        try {
          UserCredential user = await _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          if (user != null) {
            await _auth.currentUser.updateProfile(displayName: _name);
            await Navigator.pushReplacementNamed(context, "/");
            updateuserprofile();
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.message,
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
          ));
          print(e);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  'Username',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: TextFormField(
                      autocorrect: false,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        contentPadding: EdgeInsets.only(left: 16.0),
                        hintText: 'Enter username',
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
                      onSaved: (input) => _name = input),
                ),
                SizedBox(
                  height: 10,
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
                      validator: validateEmail,
                      autocorrect: false,
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
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      contentPadding: EdgeInsets.only(left: 16.0),
                      suffixIcon: GestureDetector(
                          onTap: () {}, child: Icon(Icons.visibility)),
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
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                /* ..........................Sign In Now Button....................*/
                GestureDetector(
                  onTap: () {
                    signUp();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: primaryColor),
                    child: Center(
                        child: isLoading
                            ? CircularProgressIndicator()
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
                /* ..........................Row of Two Containers.........................*/

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
}
