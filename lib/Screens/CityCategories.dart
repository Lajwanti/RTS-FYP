import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:roottrackingsystem/Screens/CategoryDetail.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class CityCategories extends StatefulWidget {
  String cityName;
  String CityId;

  CityCategories({required this.cityName, required this.CityId});

  @override
  _CityCategoriesState createState() => _CityCategoriesState();

}

class _CityCategoriesState extends State<CityCategories> {
  Widget CustomLeft(String title){
    String Id = "";

    void getCityDocFromFirebase() async {
      await FirebaseFirestore.instance
          .collection(widget.cityName).doc(widget.CityId).collection(title)
          .get()
          .then((querySnapshot) => {
        querySnapshot.docs.forEach((doc) => {
          Id = doc.id,
          log("${title}....${Id}"),

          print("${doc.id}"),


        })

      });
      print("abc...${Id}");
    }
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        height: 120,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80), topLeft: Radius.circular(80)),
            boxShadow: [
              BoxShadow(
                color: Colors.teal,
                blurRadius: 12,
                spreadRadius: 1,
                offset: Offset(-5.0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: Text(
              title,
              style: const TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ),
      onTap: () {
        getCityDocFromFirebase();
        // Get.to(()=>CategoryDetail());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryDetail(
                  categoryDetail: title,  categoryDocId: Id,
                )));
      },
    );

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var hello= widget.CityId;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          Container(
            height: 200,
            decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(60))),
            child: Stack(
              children: [
                Positioned(
                    top: 60,
                    left: 0,
                    child: Container(
                      height: 80,
                      width: 270,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topRight: Radius.circular(50))),
                    )),
                Positioned(
                    top: 85,
                    left: 20,
                    child: Text(widget.cityName,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              CustomLeft("Marriage Hall"),
              CustomRight(title: "University"),
              CustomLeft("Restaurant"),
              CustomRight(title: "Bakery"),
              CustomLeft("Super Mart"),
              CustomRight(title: "Mall"),
              CustomLeft("Super Mart"),
              CustomRight(title: "Collage"),
            ],
          )),
          Text(widget.cityName),
          Text(widget.CityId)
        ],
      ),
    );
  }
}

class CustomRight extends StatelessWidget {
  String title = "";

  CustomRight({required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        height: 120,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(80),
                topRight: Radius.circular(80)),
            boxShadow: [
              BoxShadow(
                color: Colors.teal,
                blurRadius: 12,
                spreadRadius: 1,
                offset: Offset(5.0, -5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: Text(
              title,
              style: const TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ),
      onTap: () {
        // Get.to(()=>CategoryDetail());
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CategoryDetail(
        //               categoryDetail: title,
        //             )));
      },
    );
  }
}
