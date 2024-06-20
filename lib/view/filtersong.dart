import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../music/playmusic.dart';

class FilterSong extends StatefulWidget {
  const FilterSong({Key? key, this.selectedArtist}) : super(key: key);

  final String? selectedArtist;

  @override
  State<FilterSong> createState() => _FilterSongState();
}

class _FilterSongState extends State<FilterSong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text("${widget.selectedArtist}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('songs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final songs = snapshot.data!.docs
              .where((doc) =>
          widget.selectedArtist!.isEmpty ||
              (doc.data() as Map<String, dynamic>)['artistName'] ==
                  widget.selectedArtist)
              .toList();
          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              var song = songs[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: Image.network(
                  song['photoUrl'],
                ),
                title: Text(
                  song['songName'],
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  song['artistName'],
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongPlayerPage(
                        songUrl: song['songUrl'],
                        songName: song['songName'],
                        artistName: song['artistName'],
                        photoUrl: song['photoUrl'],
                        songs: songs
                            .map((doc) => doc.data() as Map<String, dynamic>)
                            .toList(),
                        initialIndex: index,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
