import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicplay/music/uploadmusicscreen.dart';
import 'package:musicplay/view/filtersong.dart';
import 'package:musicplay/view/notification.dart';
import 'package:musicplay/view/profilepage.dart';
import 'package:musicplay/view/searchpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../music/playmusic.dart';
import 'allsongs.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String email = '';
  String selectedArtist = '';


  _loadData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('password') ?? 'No email saved';
    });
  }

  void _onArtistSelected(String artist) {
    setState(() {
      selectedArtist = artist;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterSong(selectedArtist: artist,),
      ),
    );
  }

  _play() {
    setState(() {
      //
    });
  }

  void _ontap(int index) {
    setState(() {
      _selectedIndex = index;

      // Use Navigator to push the corresponding screen onto the stack
      if (_selectedIndex == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),));
      } else if (_selectedIndex == 2) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadSongPage(),
            ));
      } else if (_selectedIndex == 3) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllSongs(),
            ));
      }
    });
  }

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(children: [
        Container(
          margin: EdgeInsets.all(1),
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Top half with the image
              Expanded(
                child: Stack(
                  children: [
                    // Your image
                    Image.asset(
                      'assets/weeknd.png',
                      fit: BoxFit.cover,
                      width: width, // Ensure the image covers the width
                    ),
                    // Apply blur effect
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.black.withOpacity(
                            0.60), // Transparent container to apply blur
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom half with dark grey color
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProFilePage(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white10)),
                        height: 55,
                        width: 55,
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Hi, John ",
                        style: TextStyle(color: Colors.grey[500], fontSize: 25),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(),));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
                        height: 55,
                        width: 55,
                        child: Icon(
                          Icons.notifications_none_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                width: width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 30,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white12)),
                        onPressed: () {
                          _onArtistSelected('Relax');

                        },
                        child: Text(
                          'Relax',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white12)),
                        onPressed: () {
                          _onArtistSelected('Justin Bieber');
                        },
                        child: Text(
                          'Justin',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),

                    Container(
                      height: 20,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white12)),
                        onPressed: () {
                          _onArtistSelected('Weekend');
                        },
                        child: Text(
                          'Weekend',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),

                    Container(
                      padding: EdgeInsets.all(5),
                      height: 30,
                      width: 130,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white12)),
                        onPressed: () {
                          _onArtistSelected('Wiz Khalifa');
                        },
                        child: Text(
                          'Wiz Khalifa',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),

                    Container(
                      padding: EdgeInsets.all(5),
                      height: 30,
                      width: 130,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white12)),
                        onPressed: () {
                          _onArtistSelected('Emotional');
                        },
                        child: Text(
                          'Emotional',
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        ),
                      ),
                    ) // Add more buttons as needed
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 30,
                width: 400,
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Artist for you",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Center(
                      child: InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AllSongs(),));

                      },
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          alignment: Alignment.center,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "View all",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 130,
                  width: width,
                  margin: EdgeInsets.all(5),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('songs').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final songs = snapshot.data!.docs;
                        return
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              var song = songs[index].data() as Map<String, dynamic>;
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SongPlayerPage(
                                            songUrl: song['songUrl'],
                                            songName: song['songName'],
                                            artistName: song['artistName'],
                                            photoUrl: song['photoUrl'],
                                            songs: songs.map((doc) => doc.data() as Map<String, dynamic>).toList(),
                                            initialIndex: index,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius: BorderRadius.all(
                                            Radius.elliptical(20, 20),
                                          )),
                                      height: 150,
                                      width: 320,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Container(
                                                width :150,
                                                child: Text(
                                                  song['songName'],
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  song['artistName'],
                                                  style: TextStyle(     overflow: TextOverflow.ellipsis, // This line will add an ellipsis to the text



                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.grey[400]),
                                                ),
                                              ),

                                              Container(
                                                  height: 50,
                                                  child: IconButton(
                                                      onPressed: () => _play,
                                                      icon: Icon(
                                                        Icons.play_circle,
                                                        size: 50,
                                                        color: Colors.white,
                                                      ))),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    20),
                                                child: Container(
                                                    height: 120,
                                                    width: 120,
                                                    child: Image.network(
                                                      song['photoUrl'],
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  )
                                ],
                              );
                            },
                          );
                      }
                  )),
              Container(
                height: 30,
                width: 400,
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "New Releases",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Center(
                      child: InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AllSongs(),));
                      },
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          alignment: Alignment.center,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Play all",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 250,
                  width: width,
                  margin: EdgeInsets.all(5),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('songs').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final songs = snapshot.data!.docs;
                        return  ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            var song = songs[index].data() as Map<
                                String,
                                dynamic>;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SongPlayerPage(
                                          songUrl: song['songUrl'],
                                          songName: song['songName'],
                                          artistName: song['artistName'],
                                          photoUrl: song['photoUrl'],
                                          songs: songs.map((doc) => doc.data() as Map<String, dynamic>).toList(),
                                          initialIndex: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white10,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              )),
                                          height: 250,
                                          width: 210,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              child: Image.network(
                                                song["photoUrl"],
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black45,
                                                  // Adjust opacity here (0.0 to 1.0)

                                                  borderRadius: BorderRadius
                                                      .only(
                                                      bottomRight: Radius
                                                          .circular(30),
                                                      bottomLeft: Radius
                                                          .circular(30))),
                                              height: 60,
                                              width: 210,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Container(
                                                        child: Container(
                                                          width:80,
                                                          child: Text(
                                                            song["songName"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontSize: 15,
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:80,
                                                        child: Text(
                                                          song["artistName"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[400]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                      bottom: 30,
                                                      left: 40,
                                                    ),
                                                    child: Container(
                                                      alignment: Alignment
                                                          .center,
                                                      height: 50,
                                                      child: IconButton(
                                                          onPressed: _play,
                                                          icon: Icon(
                                                            Icons.play_circle,
                                                            color: Colors
                                                                .white,
                                                            size: 50,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                              ],
                            );
                          },
                        );

                      }
                  )),
            ],
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: true,
        onTap: _ontap,
        iconSize: 15,
        selectedIconTheme: IconThemeData(
          size: 28,
        ),
        unselectedIconTheme: IconThemeData(
          size: 25,
          color: Colors.grey[600],
        ),
        selectedFontSize: 8,
        unselectedFontSize: 10,
        selectedItemColor: Colors.red[600],
        showUnselectedLabels: true,
        backgroundColor: Colors.black54,
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyle(
            fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
        selectedLabelStyle: TextStyle(
            fontSize: 13,
            color: Colors.pink,
            letterSpacing: 1,
            fontWeight: FontWeight.bold),
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home_rounded,
              )),
          BottomNavigationBarItem(
              label: "Search",
              icon: Icon(
                Icons.search,
              )),
          BottomNavigationBarItem(
            label: "Upload",
            icon: Icon(
              Icons.add_circle_outline,
            ),
          ),
          BottomNavigationBarItem(
              label: "My Music",
              icon: Icon(
                Icons.play_arrow_outlined,
              )),
        ],
      ),
    );
  }
}
