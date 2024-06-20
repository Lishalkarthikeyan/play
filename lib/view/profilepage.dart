
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  late SharedPreferences prefs;
  String? username;
  String? password;
  Future<void>_loadData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'No email saved';
      password = prefs.getString('password') ?? 'No phone number saved';
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme:
        IconThemeData(color: Colors.white ),
        backgroundColor: Colors.black,
        title: Text("Profile",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w500),),),
      body: Container(
        child:  ListView(
      padding: const EdgeInsets.all(0),
      children: [
         DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.black,
          ), //BoxDecoration
          child: UserAccountsDrawerHeader(

            decoration: BoxDecoration(color: Colors.black),
            accountName: Container(
              child: Text(
                "Name : S.Lishal Karthikeyan",
                style: TextStyle(fontSize: 18),
              ),
            ),
            accountEmail: Text("Email : lishalkarthikeyan008@gmail.com"),
            currentAccountPictureSize: Size.square(45),
            currentAccountPicture: CircleAvatar(

              backgroundColor: Colors.white,
              child: Text(
                "LS",
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ), //Text
            ), //circleAvatar
          ), //UserAccountDrawerHeader
        ), //DrawerHeader
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text(' Edit Profile '),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('LogOut'),
          onTap: () async {
            SharedPreferences prefs =
            await SharedPreferences.getInstance();
            await prefs.remove('username');
            await prefs.remove('password');
            await prefs.remove('email');
            await prefs.remove('phone');
            await prefs.remove('isLoggedIn');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Logged out Sucessfully",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.black,
                duration: Duration(milliseconds: 1300),
                behavior: SnackBarBehavior.floating,
                closeIconColor: Colors.white,
              ),
            );

            Navigator.pushReplacementNamed(context, 'loginpage');
          },
        ),
      ],
    ),
      ) ,
    );
  }
}
