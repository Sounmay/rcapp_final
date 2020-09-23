import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlert extends StatefulWidget {
  final title;
  final description;
  final url;
  CustomAlert({this.title, this.description, this.url});
  @override
  _CustomAlertState createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContext(context),
    );
  }

  dialogContext(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 100, 16, 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 10))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: GoogleFonts.inter(),
              ),
              SizedBox(height: 24),
              Text(
                widget.description,
                style: GoogleFonts.inter(),
              ),
              SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK')),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.orangeAccent,
            radius: 50,
            backgroundImage: AssetImage(widget.url),
          ),
        )
      ],
    );
  }
}
