import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:roottrackingsystem/Screens/CityCategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//create custom tabBar for province

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff9cc6bc),
                  Color(0xff6ca6bb),
                  Color(0xff9cc6bc),
                ]),
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(35),
            //     bottomRight: Radius.circular(35))
          ),
          child: const Center(
              child: Text(
            "Cities of Pakistan",
            style: TextStyle(
                fontSize: 27,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          )),
        ),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
              //Background Images
                image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),

        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    //color: Colors.amberAccent,
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      // begin: Alignment.topCenter,
                      // end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff228DA7),
                        Color(0xff52b7bf),
                        Color(0xff85c7de),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                //Tab Bar for province
                child: TabBar(
                  controller: _controller,
                  indicator: BoxDecoration(
                      color: const Color(0xff08ADA1),
                      borderRadius: BorderRadius.circular(30.0)),
                  labelColor: Color(0xffffffff),
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                        child: Text(
                      "Sindh",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                    Tab(
                        child: Text(
                      'Punjab',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                    Tab(
                        child: Text(
                      'KPK',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Tab(
                          child: Text(
                        'Baloch',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),


            //Tab Bar View for cities name
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 60),
              child: TabBarView(
                controller: _controller,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomCard(title: "Karachi"),
                        CustomCard(title: "Hyderabad"),
                        CustomCard(title: "Sukkur"),
                        CustomCard(title: "Larkana"),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomCard(title: "Lahore"),
                        CustomCard(title: "Multan"),
                        CustomCard(title: "Islamabad"),
                        CustomCard(title: "Faisalabad")
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomCard(title: "Peshawar"),
                        CustomCard(title: "Mardan"),
                        CustomCard(title: "Kohat"),
                        CustomCard(title: "Abbottabad")
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomCard(title: "Quetta"),
                        CustomCard(title: "Gwadar"),
                        CustomCard(title: "Turbat"),
                        CustomCard(title: "Khuzdar")
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //bottom bubble lottie file
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset(
                  'images/bubbles.json',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//create custom card for show city names
class CustomCard extends StatefulWidget {
  CustomCard({Key? key, required this.title}) : super(key: key);

  String title = "";

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  String docId = '';


  //Get document Id of city from firebase
  void getCityDocFromFirebase() async {
    await FirebaseFirestore.instance
        .collection(widget.title)
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    docId = doc.id,
                    log("${widget.title}....$docId"),
                    print(docId),
                  })
            });
    log("abc...$docId");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getCityDocFromFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white60,
        child: ListTile(
          title: Text(
            widget.title,
            style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700),
          ),
        ),
        elevation: 8,
        shadowColor: Colors.greenAccent,
        margin: const EdgeInsets.all(15),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xff18B3A4), width: 3),
        ),
      ),
      onTap: () {
        //Navigate to city categories
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CityCategories(cityName: widget.title, CityId: docId)));
        //getCityDocFromFirebase();
        //print("doc Id...${docId}");
      },
    );
  }
}
