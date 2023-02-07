import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:take_home/Screens/Home/components/project_item.dart';
import 'package:take_home/Screens/Home/components/title_row.dart';
import 'package:take_home/Screens/board_screen/board_screen.dart';
import 'package:take_home/utils/constants.dart';
import 'components/add_project.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              //color: Color(0xFFD4E7FE),
                gradient: LinearGradient(
                    colors: [
                      kBackgroundColor,
                      Color(0xFFF0F0F0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.6, 0.3])),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                        text: DateFormat('EEE').format(now),
                        style: const TextStyle(
                            color: Color(0XFF263064),
                            fontSize: 12,
                            fontWeight: FontWeight.w900),
                        children: [
                          TextSpan(
                            text: " ${DateFormat('dd MMM').format(DateTime.now())}",
                            style: const TextStyle(
                                color: Color(0XFF263064),
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          )
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.2),
                            blurRadius: 12,
                            spreadRadius: 8,
                          )
                        ],
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hi User",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome to Take Home Challenge",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 155,
            child: Container(
              height: MediaQuery.of(context).size.height - 155,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: const [
                    TitleRow(title: 'YOUR PROJECTS', number: 3,),
                    SizedBox(
                      height: 20,
                    ),
                    BuildProjectItem(),
                    BuildProjectItem(),
                    BuildAddProject(),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}