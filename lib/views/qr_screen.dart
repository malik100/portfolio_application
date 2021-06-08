import 'package:flutter/material.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: getBody(context),
    );
  }
  Widget getBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Center(
          child: Image.asset(
            'images/qrcode.png',
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
        Text('Scan this QR code'),
      ],
    );
  }
}
