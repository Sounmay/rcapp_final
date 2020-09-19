import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rcapp/services/database.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
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
                    Text('Camera',
                        style: GoogleFonts.inter(
                            color: Colors.black, fontWeight: FontWeight.bold))
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
                        Text('ADD AN IMAGE',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500, fontSize: 20))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Food Name',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => val.isEmpty ? 'Enter Food Name' : null,
                    onChanged: (val) {
                      setState(() => food = val);
                    }),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Food Price',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => val.isEmpty ? 'Enter Food Price' : null,
                    onChanged: (val) {
                      setState(() => price = int.tryParse(val));
                    })
              ],
              if (_pickedImage != null) ...[
                Image.file(_pickedImage),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Food Name',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => val.isEmpty ? 'Enter Food Name' : null,
                    onChanged: (val) {
                      setState(() => food = val);
                    }),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Food Price',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => val.isEmpty ? 'Enter Food Price' : null,
                    onChanged: (val) {
                      setState(() => price = int.tryParse(val));
                    }),
                SizedBox(height: 10),
                Uploader(file: _pickedImage, food: food, price: price),
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
  final food;
  final price;
  final file;
  Uploader({this.file, this.food, this.price});
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://rcapp-de25c.appspot.com');
  // StorageUploadTask _uploadTask;

  var _uploadTask;

  final DatabaseService _todayMenuUploader = DatabaseService();

  Future _startUpload(String food, int price) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('today_menu')
          .child('${DateTime.now()}.jpg');

      setState(() {
        _uploadTask = ref.putFile(widget.file);
      });

      await ref.putFile(widget.file).onComplete;

      final url = await ref.getDownloadURL();

      _todayMenuUploader.updateTodayMenu(food, price, url);
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
          _startUpload(widget.food, widget.price);
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
