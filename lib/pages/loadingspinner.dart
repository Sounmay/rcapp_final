import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange[100],
      child: Center(child: SpinKitCircle(color: Colors.deepOrange,size: 50),),
    );
  }
}