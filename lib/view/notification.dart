import 'package:flutter/material.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text('Notification',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),),
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: Image.asset("assets/notification.png",fit: BoxFit.cover,),
            ),
            SizedBox(height: 10,),
            Text("No Nofification ! ",style: TextStyle(color: Colors.black,fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.bold),)
          ],
        ),),

      ),

    );
  }
}
