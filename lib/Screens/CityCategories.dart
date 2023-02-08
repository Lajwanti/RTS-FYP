import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roottrackingsystem/Screens/CategoryDetail.dart';


class CityCategories extends StatefulWidget {
  String cityName;
  String CityId;

  CityCategories({required this.cityName, required this.CityId});

  @override
  _CityCategoriesState createState() => _CityCategoriesState();
}


class _CityCategoriesState extends State<CityCategories> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
          Container(

            height:  MediaQuery.of(context).size.height * .25,
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
            ),),
             SafeArea(
              child: Column(

                children: <Widget>[
                  Row(
                    children: [
                      GestureDetector(
                        child: const Padding(
                          padding:  EdgeInsets.all(10.0),
                          child:  Icon(Icons.navigate_before,size: 40,color: Colors.black,),
                        ),
                        onTap:(){
                          //Navigate to Back
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width:30),
                      Text(widget.cityName,
                        style: const TextStyle(color: Colors.black, fontSize: 35),),
                    ],
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Marriage Hall
                                Categorycard(
                                    title: "Marriage Hall",
                                    asset: "images/marriage.jpg",
                                    cityNm: widget.cityName,
                                    cityDocId: widget.CityId),
                                const SizedBox(width: 10,),

                                //Restaurant
                                Categorycard(
                                    title: "Restaurant",
                                    asset: "images/restaurant.jpg",
                                    cityNm: widget.cityName,
                                    cityDocId: widget.CityId),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                //SuperMart
                                Categorycard(
                                    title: "Super Mart",
                                    asset: "images/supermart.jpg",
                                    cityNm: widget.cityName,
                                    cityDocId: widget.CityId),
                                const SizedBox(width: 10,),

                                //Shopping Mall

                                Categorycard(
                                    title: "Mall",
                                    asset: "images/mall.jpg",
                                    cityNm: widget.cityName,
                                    cityDocId: widget.CityId),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [


                                //Hospital
                                Categorycard(
                                    title: "Hospital",
                                    asset: "images/hospital.jpg",
                                    cityNm: widget.cityName,
                                    cityDocId: widget.CityId),
                                const SizedBox(width: 10,),

                                //University
                                Categorycard(
                                    title: "University",
                                    asset: "images/university.jpg",
                                    cityNm: widget.cityName,
                                    cityDocId: widget.CityId),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                //College
                                Categorycard(
                                    title: "College",
                                    asset: "images/college.jpg",
                                    cityNm: widget.cityName,
                                    cityDocId: widget.CityId),
                                const SizedBox(width: 10,),

                                //Bakery
                                Categorycard(
                                    title: "Bakery",
                                    asset: "images/bakery.png",
                                    cityNm: widget.cityName,
                                    cityDocId: widget.CityId),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

        ],
      )
    );
  }
}

//create custom class for city categories
class Categorycard extends StatefulWidget {
  final String asset;
  String title = "";
  String cityNm;
  String cityDocId;

  Categorycard(
      {
        required this.title,
        required this.cityNm,
        required this.cityDocId,
        required this.asset,
      });

  @override
  State<Categorycard> createState() => _CategorycardState();
}

class _CategorycardState extends State<Categorycard> {
  String Id = "";


  //get document ID of that city category

  void getCityCategoryDocFromFirebase() async {
    await FirebaseFirestore.instance
        .collection(widget.cityNm)
        .doc(widget.cityDocId)
        .collection(widget.title)
        .get()
        .then((querySnapshot) => {
      querySnapshot.docs.forEach((doc) => {
        Id = doc.id,
        log("${widget.title}....${Id}"),
        print("${doc.id}"),
      })
    });
    print("abc...${Id}");
  }

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getCityCategoryDocFromFirebase();
    });
  }
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            child: Container(
              //padding:EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  width: 3,
                  color: Color(0xff008080),
                ),
              ),

              child:Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            //color: Color(0xffECEAE4),
                              width: 130.0,
                              height: 130.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10), // Image border
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(45), // Image radius
                                  child: Image.asset(widget.asset, fit: BoxFit.cover),
                                ),
                              )
                          ),
                    ),
                    //const SizedBox(height: ,),

                    Text(widget.title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff008080),
                        //backgroundColor: Colors.yellow[200],
                      ),),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
              onTap:(){
              //Navigate to category detail
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        CategoryDetail(
                            cityCategoryDetail: widget.title,
                            cityCategoryDocId: Id,
                            cityNm: widget.cityNm,
                            cityDocId: widget.cityDocId)));
              }
          ),
        ),
      ],
    );
  }
}