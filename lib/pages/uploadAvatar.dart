import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rcapp/services/database.dart';

class UploadAvatar extends StatefulWidget {
  @override
  _UploadAvatarState createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  @override
  Widget build(BuildContext context) {
    return ImageCapture();
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _pickedImage;

  bool showOptions = false;

  String food = '';
  int price = 0;

  bool exists = false;
  var userId = '';

  void initialize() async {
    var uid = (await FirebaseAuth.instance.currentUser()).uid;
    var result =
        await Firestore.instance.collection('userInfo').document(uid).get();
    var _avatar = result.data["avatar"];
    print(_avatar);
    setState(() {
      userId = uid;
    });
    if (_avatar != "") {
      setState(() {
        exists = true;
      });
    }
  }

  void _pickImage(ImageSource source) async {
    final pickedImageFile = await ImagePicker.pickImage(
        source: source, imageQuality: 100, maxWidth: 350, maxHeight: 280);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _clear() {
    setState(() => _pickedImage = null);
  }

  void toggle() {
    setState(() {
      showOptions = !showOptions;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Upload Image'),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (showOptions == true) ...[
                Container(
                  height: 90,
                  child: Column(children: <Widget>[
                    IconButton(
                      iconSize: 40,
                      color: Colors.deepOrange,
                      icon: Icon(Icons.photo_library),
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                    Text(
                      'File Explorer',
                      style: GoogleFonts.inter(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ]),
                ),
                Container(
                  height: 90,
                  child: Column(children: <Widget>[
                    IconButton(
                      iconSize: 40,
                      color: Colors.deepOrange,
                      icon: Icon(Icons.camera),
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                    Text(
                      'Camera',
                      style: GoogleFonts.inter(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ]),
                )
              ]
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: Column(children: <Widget>[
              if (_pickedImage == null) ...[
                Center(
                  child: Container(
                    width: 320,
                    height: 250,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.deepOrange, width: 2.0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            toggle();
                          },
                          iconSize: 40,
                          icon: Icon(Icons.image),
                        ),
                        SizedBox(height: 5),
                        Text(exists ? 'Update Profile Pic' : 'Add Profile Pic',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500, fontSize: 20))
                      ],
                    ),
                  ),
                ),
              ],
              if (_pickedImage != null) ...[
                Image.file(_pickedImage),
                SizedBox(height: 10),
                Uploader(file: _pickedImage, userId: userId),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.deepOrange,
                        child: Icon(Icons.refresh),
                        onPressed: _clear,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                      ),
                    ]),
              ]
            ]),
          ),
        ));
  }
}

class Uploader extends StatefulWidget {
  final userId;
  final file;
  Uploader({this.file, this.userId});
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://rcapp-de25c.appspot.com');
  // StorageUploadTask _uploadTask;

  var _uploadTask;

  final DatabaseService _todayMenuUploader = DatabaseService();

  Future _startUpload() async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('userAvatar')
          .child('${DateTime.now()}.jpg');

      setState(() {
        _uploadTask = ref.putFile(widget.file);
      });

      await ref.putFile(widget.file).onComplete;

      final url = await ref.getDownloadURL();

      _todayMenuUploader.updateAvatar(url, widget.userId);
      print(url);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;

          return Column(children: <Widget>[
            if (_uploadTask.isComplete) Text("Uploaded To Database"),
            LinearProgressIndicator(value: progressPercent),
            Text('${(progressPercent * 100).toStringAsFixed(2)} %')
          ]);
        },
      );
    } else {
      return FlatButton.icon(
        onPressed: () {
          _startUpload();
        },
        icon: Icon(Icons.cloud_upload),
        label: Text(
          'Save Data To List',
          style: GoogleFonts.inter(fontSize: 17),
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        color: Colors.deepOrange,
      );
    }
  }
}
