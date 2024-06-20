import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../firebase/firebasecreateuser.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;

  late SharedPreferences prefs;

  final _formkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();

  void clear() {
    _emailcontroller.clear();
    _phonecontroller.clear();
    _passwordcontroller.clear();
    _confirmpasswordcontroller.clear();
  }

  void dispose() {
    super.dispose();
  }

  Future<void> _registreLoginSharedpreference() async {
    CircularProgressIndicator();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = _emailcontroller.text;
    String phone = _passwordcontroller.text;
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setBool('isLoggedIn', true);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('homepages', (Route route) => true);
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body:
        SingleChildScrollView(
          child:
           Container(
            height: height,
            width: width,
            color: Colors.black,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(height: 100,color: Colors.white,),
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
                      height: height / 1.40,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.elliptical(30, 30)
                              ),
                          border: Border.all(color: Colors.white, width: 0.20)),
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Create Account",
                                style: TextStyle(
                                    fontSize: 45,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
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
                                      margin: EdgeInsets.only(left: 40, right: 40),
                                      child: TextFormField(
                                          controller: _emailcontroller,
                                          decoration: InputDecoration(
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
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 70,
                                      width: 330,
                                      margin: EdgeInsets.only(left: 40, right: 40),
                                      child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          controller: _phonecontroller,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.phone_outlined,
                                                color: Colors.black,
                                              ),
                                              prefixText: "+91 ",
                                              prefixStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                              labelText: "Phone Number",
                                              labelStyle:
                                              TextStyle(color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.elliptical(30, 30),
                                                  ))),
                                          validator: (a) {
                                            if (a == null || a.isEmpty) {
                                              return "Please enter a phone number";
                                            } else if (a.length != 10) {
                                              return "Please enter 10 digits";
                                            }
                                            return null; // Return null if validation passes
                                          }),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 70,
                                      width: 330,
                                      margin: EdgeInsets.only(left: 40, right: 40),
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: _passwordcontroller,
                                          decoration: InputDecoration(
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
                                              return 'Please enter an Password.';
                                            } else if (!passRegExp.hasMatch(a)) {
                                              return 'Passwoed contain 8 digit with one Capital letter.';
                                            }
                                            return null;
                                          }),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 70,
                                      width: 330,
                                      margin: EdgeInsets.only(left: 40, right: 40),
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: _confirmpasswordcontroller,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.password_sharp,
                                                color: Colors.black,
                                              ),
                                              labelText: "Confirm Password",
                                              labelStyle:
                                              TextStyle(color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.elliptical(30, 30),
                                                  ))),
                                          validator: (a) {
                                            if (a == null || a.isEmpty) {
                                              return 'Please enter an Password.';
                                            } else if (a !=
                                                _passwordcontroller.text) {
                                              return 'Password does not match';
                                            }
                                            return null;
                                          }),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ])),
                              InkWell(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    bool registerSucessful = await Authentication()
                                        .registerUser(
                                        context,
                                        _emailcontroller.text,
                                        _passwordcontroller.text);
                                    if (registerSucessful) {
                                      _registreLoginSharedpreference();
                                      clear();
                                      dispose();
                                    } else {
                                      print("Error Registering user");
                                      setState(() {
                                        _isLoading = false;

                                      });
                                    }
                                  }
                                },
                                child: _isLoading ? CircularProgressIndicator():
                                Container(
                                  alignment: Alignment.center,
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
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
                                    padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account? ",
                                    style: TextStyle(
                                        color: Colors.green[600],
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, "loginpage");
                                    },
                                    child: Container(
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),

                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      
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
