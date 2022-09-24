import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:roottrackingsystem/Screens/CityCategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  String name = "";
  String Id = "";


  Widget customCard(String title) {

    void getCityDocFromFirebase() async {
      await FirebaseFirestore.instance
          .collection(title)
          .get()
          .then((querySnapshot) => {
        querySnapshot.docs.forEach((doc) => {
          Id = doc.id,
          log("hello.....${title}....${Id}")

          //print("${doc.id}"),

        })

      });

    }

    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700),
          ),
        ),
        elevation: 8,
        shadowColor: Colors.purple,
        margin: const EdgeInsets.all(15),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueGrey, width: 2)),
      ),

      onTap: () {
        getCityDocFromFirebase();


        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CityCategories(cityName: title,CityId: Id)));
      },
    );
  }

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
        preferredSize: const Size.fromHeight(110.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'Cities',
            style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          bottom: TabBar(
            controller: _controller,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.greenAccent,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // Creates border
                color: Colors.blueGrey),
            tabs: // tabs
                [
              const Tab(
                child: Text(
                  "Sindh",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              const Tab(
                child: Text(
                  "Punjab",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Tab(
                child: GestureDetector(
                  child: const Text(
                    "KPK",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  onTap: () {
                    //pNames("KPk");
                  },
                ),
              ),
              const Tab(
                child: Text(
                  "Baloch",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset(
                'images/bubbles.json',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TabBarView(
              controller: _controller,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      customCard("Karachi"),
                      customCard("Hyderabad"),
                      customCard("Sukkur"),
                      customCard("Larkana"),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      customCard("Lahore"),
                      customCard("Multan"),
                      customCard("Islamabad"),
                      customCard("Faisalabad")
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      customCard("Peshawar"),
                      customCard("Mardan"),
                      customCard("Kohat"),
                      customCard("Abbottabad")
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      customCard("Quetta"),
                      customCard("Gawadar"),
                      customCard("Turbat"),
                      customCard("abc")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
