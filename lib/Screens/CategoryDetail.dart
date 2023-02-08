import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';


class CategoryDetail extends StatefulWidget {
  String cityCategoryDetail;
  String cityCategoryDocId;
  String cityNm;
  String cityDocId;
  CategoryDetail(
      {required this.cityCategoryDetail,
      required this.cityCategoryDocId,
      required this.cityNm,
      required this.cityDocId});

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final double _borderRadius = 24.0;

  //url Launch for call
 void urlLaunch(number)async{

   final Uri launchUri = Uri(
       scheme: 'tel',
       path: number
   );
   if(await canLaunchUrl(launchUri)){
     //await canLaunchUrl(launchUri);
     await launch(launchUri.toString());
   }
   else{
     print("this action is not supported");
   }
 }


 //go to google map
  void googleMap(location)async{

    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=${location}";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else
      throw ("Couldn't open google maps");

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   log("city name...${widget.cityNm} ... ${widget.cityDocId}");
    log("city category...${widget.cityCategoryDetail} ... ${widget.cityCategoryDocId}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff9cc6bc),
                  Color(0xff6ca6bb),
                  Color(0xff9cc6bc),

                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                GestureDetector(
                               child:const Icon(Icons.navigate_before,size: 40,color: Colors.black,),
                               onTap:(){
                                 Navigator.pop(context);
                               },
                             ),
                             const SizedBox(width:30),
                  //Category Name
                  Text(widget.cityCategoryDetail,
                    style: const TextStyle(color: Colors.black, fontSize: 40),),
                ],
              )
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),

                  //fetch data of that category which we do select
                  child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(widget.cityNm).doc(widget.cityDocId)
                      .collection(widget.cityCategoryDetail).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {


                      if(snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                        QuerySnapshot doc = snapshot.data as QuerySnapshot;

                        return ListView.builder(
                            itemCount: doc.docs.length,
                            itemBuilder: (context, index) {
                              //log(doc.toString());
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 200,

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          border: Border.all(
                                            width: 3,
                                            color: const Color(0xff18B3A4),
                                          ),
                                          gradient:const LinearGradient(colors: [
                                           Color(0xffffffff),
                                            Color(0xFFcfe8ef)
                                          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0xFFcfe8ef),
                                              blurRadius: 12,
                                              offset: Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        child: CustomPaint(
                                          size: const Size(100, 150),
                                          painter: CustomCardShapePainter(
                                              radius: _borderRadius,
                                              startColor: const Color(0xffffffff),
                                              endColor:  const Color(0xFFcfe8ef)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              //Name of that categories
                                              Row(
                                                children: [
                                                 const Icon(Icons.home_outlined),
                                                  const SizedBox(width: 5),
                                                  const Text("Name :  ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700


                                                  )),

                                                  Expanded(
                                                    child: Text("${doc.docs[index]["name"]}",
                                                      maxLines: 6,
                                                      overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.w500


                                                        )
                                                      // textDirection: TextDirection.rtl,
                                                      //textAlign: TextAlign.justify,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              const SizedBox(height: 15),


                                              //phone of that categories
                                              Row(
                                                children: [
                                                  const Icon(Icons.phone),
                                                  const SizedBox(width: 5),
                                                  const Text("Phone :  ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w700


                                                      )),
                                                  GestureDetector(
                                                    child: Text("${doc.docs[index]["contact"]}",
                                                      maxLines: 6,
                                                      overflow: TextOverflow.ellipsis,
                                                      // textDirection: TextDirection.rtl,
                                                      //textAlign: TextAlign.justify,
                                                    ),
                                                    onTap: () {
                                                      String number = doc.docs[index]["contact"];
                                                      urlLaunch(number);
                                                    }
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 15),

                                              //Address of that categories
                                              Row(
                                                children: [
                                                  const Icon(Icons.location_on_outlined),
                                                  const SizedBox(width: 2),
                                                 const Text("Address : ",
                                                     style: TextStyle(
                                                         fontWeight: FontWeight.w700


                                                     )),
                                                  //Text("Address...${doc.docs[index]["address"]}"),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      child: Text("${doc.docs[index]["address"]}",
                                                        maxLines: 8,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          decoration: TextDecoration.underline,
                                                        ),
                                                        //textDirection: TextDirection.rtl,
                                                        //textAlign: TextAlign.justify,
                                                      ),
                                                      onTap: (){
                                                        String location = doc.docs[index]["address"];
                                                        googleMap(location);
                                                      }
                                                    ),
                                                  ),
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
                            });
                      }
                        else if (!snapshot.hasData) {
                          return const Center(
                            child: Text("No Data Found"),
                          );
                        }

                    }



                    return Container();


                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


//custom class for shade painter that we use in cards
class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(
      {required this.radius, required this.startColor, required this.endColor});

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0), Offset(size.width, size.height), [
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
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
