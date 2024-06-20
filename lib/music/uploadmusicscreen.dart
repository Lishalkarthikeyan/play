import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class UploadSongPage extends StatefulWidget {
  @override
  _UploadSongPageState createState() => _UploadSongPageState();
}

class _UploadSongPageState extends State<UploadSongPage> {
  final _formKey = GlobalKey<FormState>();
  String _artistName = '';
  String _songName = '';
  PlatformFile? _songFile;
  PlatformFile? _photoFile;
  bool _isUploadingSong = false;
  bool _isUploadingPhoto = false;

  Future<void> _pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: type == 'song' ? ['mp3'] : ['jpg', 'png'],
    );
    if (result != null) {
      setState(() {
        if (type == 'song') {
          _songFile = result.files.first;
        } else {
          _photoFile = result.files.first;
        }
      });
    }
  }

  Future<void> _uploadFile(BuildContext context) async {
    if (_formKey.currentState!.validate() && _songFile != null && _photoFile != null) {
      _formKey.currentState!.save();

      setState(() {
        _isUploadingSong = true;
        _isUploadingPhoto = true;
      });

      try {
        // Upload song
        String songFileName = basename(_songFile!.path!);
        UploadTask songUploadTask = FirebaseStorage.instance
            .ref('songs/$songFileName')
            .putFile(File(_songFile!.path!));
        TaskSnapshot songSnapshot = await songUploadTask;
        String songUrl = await songSnapshot.ref.getDownloadURL();
        setState(() {
          _isUploadingSong = false;
        });

        // Upload photo
        String photoFileName = basename(_photoFile!.path!);
        UploadTask photoUploadTask = FirebaseStorage.instance
            .ref('photos/$photoFileName')
            .putFile(File(_photoFile!.path!));
        TaskSnapshot photoSnapshot = await photoUploadTask;
        String photoUrl = await photoSnapshot.ref.getDownloadURL();
        setState(() {
          _isUploadingPhoto = false;
        });

        // Save metadata to Firestore
        await FirebaseFirestore.instance.collection('songs').add({
          'artistName': _artistName,
          'songName': _songName,
          'songUrl': songUrl,
          'photoUrl': photoUrl,
        });

        // Clear the form
        setState(() {
          _artistName = '';
          _songName = '';
          _songFile = null;
          _photoFile = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Row(
            children: [
              Text('Song uploaded successfully!',style: TextStyle(color: Colors.black,fontSize: 20),),
              SizedBox(width: 10,),Icon(Icons.ac_unit_sharp,color: Colors.green[600],)
            ],
          ), backgroundColor: Colors.white),
        );

        // Navigate to the home page with a success message
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        setState(() {
          _isUploadingSong = false;
          _isUploadingPhoto = false;
        });

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Row(
          children: [
            Text('Please Pick Both Photo And Song',style: TextStyle(color: Colors.black,fontSize: 20),),
            SizedBox(width: 10,),Icon(Icons.ac_unit_sharp,color: Colors.green[600],)
          ],
        ), backgroundColor: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Upload Song', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Upload Your Own Song To PlayMusic",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(height: 50),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Artist Name', labelStyle: TextStyle(color: Colors.white)),
                validator: (value) => value!.isEmpty ? 'Please enter artist name' : null,
                onSaved: (value) => _artistName = value!,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Song Name', labelStyle: TextStyle(color: Colors.white)),
                validator: (value) => value!.isEmpty ? 'Please enter song name' : null,
                onSaved: (value) => _songName = value!,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickFile('photo'),
                    child: Text(
                      'Pick Photo',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  if (_photoFile != null)
                    Container(
                      width: 100,
                      child: Text(
                        _photoFile!.name,
                        style: TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                ],
              ),
              if (_isUploadingPhoto) CircularProgressIndicator(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickFile('song'),
                    child: Container(
                        child: Text(
                          'Pick Song',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                  if (_songFile != null)
                    Container(
                      width: 100,
                      child: Text(
                        _songFile!.name,
                        style: TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                ],
              ),
              if (_isUploadingSong) CircularProgressIndicator(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _uploadFile(context),
                    child: Text('Upload Song', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
