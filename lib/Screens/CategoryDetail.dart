import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CategoryDetail extends StatefulWidget {

  String categoryDetail;
  String categoryDocId;
   CategoryDetail({required this.categoryDetail, required this.categoryDocId});

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final double _borderRadius =24.0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        PreferredSize(
          preferredSize: const Size.fromHeight(80.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            elevation: 40,
            automaticallyImplyLeading: false,
            title:  Text(widget.categoryDocId,
              style: const TextStyle(
                  fontSize:15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
        ),
      body: ListView.builder(
        itemCount: 4,
          itemBuilder: (context, index) {
            return  Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                              colors: [Colors.green,Colors.teal],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.teal,
                                blurRadius: 12,
                                offset: Offset(0,6)
                            )
                          ]
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: CustomPaint(
                          size: const Size(100,150),
                          painter: CustomCardShapePainter(
                              radius: _borderRadius,
                              startColor: Colors.teal,
                              endColor: Colors.green),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Column(
                          children: [
                            Row(

                              children: const [
                                Icon(Icons.home_outlined),
                                SizedBox(width: 5),
                                Text("Name"),
                              ],
                            ),
                          const  SizedBox(height: 15),
                            Row(

                              children: const [
                                Icon(Icons.phone),
                                SizedBox(width: 5),
                                Text("phone number"),
                              ],
                            ),
                           const SizedBox(height: 15),
                            Row(

                              children: const [
                                Icon( Icons.location_on_outlined),
                                Text("Location"),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }));
  }
}


class CustomCardShapePainter extends CustomPainter{
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter({
    required this.radius,
    required this.startColor,
    required this.endColor});

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
      const  Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }
@override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}