import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../firebase/firebasecreateuser.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  late SharedPreferences prefs;
  bool _isLoading = false;

  void dispose() {
    super.dispose();
  }

  void clear() {
    _emailcontroller.clear();
    _passwordcontroller.clear();
  }

  final _formkey = GlobalKey<FormState>();

  static TextEditingController _emailcontroller = TextEditingController();
  static TextEditingController _passwordcontroller = TextEditingController();

  Future<void> _loginSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = _emailcontroller.text;
    String password = _passwordcontroller.text;

    // Save login info
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setBool('isLoggedIn', true);

    // Navigate to home screen
    Navigator.pushReplacementNamed(context, 'homepages');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body:
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                height: height,
                width: width,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        height: 100,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          "Play Music",
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 60),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: height / 1.65,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.elliptical(30, 30)),
                            border: Border.all(color: Colors.white, width: 3)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome to Music World !",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                                key: _formkey,
                                child: Column(children: [
                                  Container(
                                    height: 70,
                                    width: 330,
                                    child: TextFormField(
                                        onSaved: (a) => _emailcontroller,
                                        cursorColor: Colors.pink,
                                        cursorErrorColor: Colors.red,
                                        controller: _emailcontroller,
                                        decoration: InputDecoration(
                                          // contentPadding: EdgeInsets.fromLTRB(
                                          //     20.0, 5.0, 40.0, 10.0),
                                            prefixIcon: Icon(
                                              Icons.mail_outline_outlined,
                                              color: Colors.black,
                                            ),
                                            labelText: "E-mail address",
                                            labelStyle:
                                            TextStyle(color: Colors.black),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.elliptical(30, 30),
                                                ))),
                                        validator: (a) {
                                          RegExp emailRegExp = RegExp(
                                              r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
              
                                          if (a == null || a.isEmpty) {
                                            return 'Please enter an email address.';
                                          } else if (!emailRegExp.hasMatch(a)) {
                                            return 'Please enter a valid email address.';
                                          }
                                          return null;
                                        }),
                                    margin: EdgeInsets.only(left: 40, right: 40),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 70,
                                    width: 330,
                                    child: TextFormField(
                                        onSaved: (a) => _passwordcontroller,
                                        controller: _passwordcontroller,
                                        cursorErrorColor: Colors.red,
                                        cursorColor: Colors.pink,
                                        decoration: InputDecoration(
                                          // contentPadding: EdgeInsets.fromLTRB(
                                          //     20.0, 20.0, 40.0, 10.0),
                                            prefixIcon: Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.black,
                                            ),
                                            labelText: "Password",
                                            labelStyle:
                                            TextStyle(color: Colors.black),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.elliptical(30, 30),
                                                ))),
                                        validator: (a) {
                                          RegExp passRegExp =
                                          RegExp(r'^(?=.*[a-zA-Z]).{8,}');
                                          if (a == null || a.isEmpty) {
                                            return 'Please enter a Password.';
                                          } else if (!passRegExp.hasMatch(a)) {
                                            return 'Password must contain 8 characters with one capital letter.';
                                          }
                                          return null;
                                        }),
                                    margin: EdgeInsets.only(left: 40, right: 40),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (_formkey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        _formkey.currentState?.save();
                                        bool signInSuccess = await Authentication()
                                            .signinUser(
                                            context,
                                            _emailcontroller.text,
                                            _passwordcontroller.text);
              
                                        if (signInSuccess) {
                                          _loginSharedPreference();
                                          clear();
                                        } else {
                                          print("Sign in unsuccessful");
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                                    child: _isLoading
                                        ? CircularProgressIndicator()
                                        : Container(
                                      height: 45,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(30, 30)),
                                          border: Border.all(
                                            color: Colors.pink,
                                            width: 0.30,
                                            style: BorderStyle.solid,
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Login",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ])),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  width: width / 2.5,
                                  child: Divider(
                                    height: 2,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: width / 2.5,
                                  child: Divider(
                                    height: 2,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an Account? ",
                                  style: TextStyle(
                                      color: Colors.red[600],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    clear();
                                    Navigator.pushNamed(context, "registerpage");
                                  },
                                  child: Container(
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "forgotpass");
                              },
                              child: Container(
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )


      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 100);
    path.quadraticBezierTo(size.width / 4, 60, size.width / 2, 75);
    path.quadraticBezierTo(3 / 4 * size.width, 90, size.width, 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
