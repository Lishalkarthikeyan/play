import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SongPlayerPage extends StatefulWidget {
  final String songUrl;
  final String songName;
  final String artistName;
  final String photoUrl;
  final List<Map<String, dynamic>> songs;
  final int initialIndex;

  SongPlayerPage({
    required this.songUrl,
    required this.songName,
    required this.artistName,
    required this.photoUrl,
    required this.songs,
    this.initialIndex = 0,
  });

  @override
  _SongPlayerPageState createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage> with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late AnimationController _animationController;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _audioPlayer = AudioPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      _playNextSong();
    });

    _playSong();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _playSong() async {
    await _audioPlayer.play(UrlSource(widget.songs[_currentIndex]['songUrl']));
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _pauseSong() async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  Future<void> _stopSong() async {
    await _audioPlayer.stop();
    setState(() {
      _position = Duration.zero;
      isPlaying = false;
    });
  }

  void _togglePlayPause() {
    if (isPlaying) {
      _pauseSong();
    } else {
      _playSong();
    }
  }

  void _playNextSong() {
    if (_currentIndex < widget.songs.length - 1) {
      setState(() {
        _currentIndex++;
        _playSong();
      });
    } else {
      _stopSong();
    }
  }

  void _playPreviousSong() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _playSong();
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final song = widget.songs[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(toolbarHeight: 35,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(song['artistName'],style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              height: height/1.70,
                width: width,
                color: Colors.white,

                child: Image.network(song['photoUrl'],height: 1.67,width: width,fit: BoxFit.cover,)),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              height: 30,
                width: width,
                child: Text(song['songName'], style: TextStyle(fontSize: 24,color: Colors.white))),
            Container(
              alignment: Alignment.center,
              height: 30,
                width: width,
                child: Text(song['artistName'], style: TextStyle(fontSize: 18,color: Colors.white54))),
            Container(
              width: width,
              child: Slider(
                 inactiveColor: Colors.white,
                min: 0,
                max: _duration.inSeconds.toDouble(),
                thumbColor: Colors.white,
                value: _position.inSeconds.toDouble(),activeColor: Colors.blue,secondaryActiveColor: Colors.blue,
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await _audioPlayer.seek(position);
                  await _audioPlayer.resume();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(_formatDuration(_position),style: TextStyle(color: Colors.white,fontSize: 12),),
                Text(_formatDuration(_duration),style: TextStyle(color: Colors.white,fontSize: 12),),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                ElevatedButton(
                  onPressed: _playPreviousSong,
                  child: Icon(Icons.skip_previous,color: Colors.black,),
                ),
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: AnimatedIcon(
                      color: Colors.black,
                      icon: AnimatedIcons.play_pause,
                      progress: _animationController,
                      size: 50,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _playNextSong,
                  child: Icon(Icons.skip_next,color: Colors.black,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
