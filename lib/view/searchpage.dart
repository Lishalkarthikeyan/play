import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../music/playmusic.dart';
class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  late Stream<QuerySnapshot> musicStream;

  @override
  void initState() {
    super.initState();
    musicStream = FirebaseFirestore.instance.collection('songs').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text('Music List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(style: TextStyle(color: Colors.white,),

              cursorColor: Colors.white70,
              decoration: InputDecoration(fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.white),
                hintText: "search songs",
                labelText: 'Search your Favorite songs',
                border: OutlineInputBorder(borderSide:BorderSide(color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(20)),),
                suffixIcon:Icon(Icons.search,color: Colors.white70,size: 30,)
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: musicStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final songs = snapshot.data!.docs.where((doc) {
                  var data = doc.data() as Map<String, dynamic>;
                  var songName = data['songName'].toString().toLowerCase();
                  var artistName = data['artistName'].toString().toLowerCase();
                  return songName.contains(searchQuery) || artistName.contains(searchQuery);
                }).toList();

                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      var song = songs[index].data() as Map<String, dynamic>;
                      return ListTile(
                        leading: Container(
                          height: 40,
                            width:40,color:  Colors.white,
                            child: Image.network(song['photoUrl'],fit: BoxFit.cover,height: 40,width: 40,

                              )),
                        title: Text(song['songName'],style: TextStyle(color: Colors.white,fontSize: 17),),
                        subtitle: Text(song['artistName'],style: TextStyle(color: Colors.white70,fontSize: 13),),
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

                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


