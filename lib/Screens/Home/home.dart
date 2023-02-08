import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:take_home/Screens/Home/components/project_item.dart';
import 'package:take_home/Screens/Home/components/title_row.dart';
import 'package:take_home/utils/constants.dart';
import '../../providers/Firebase/authentication/firebase_auth.dart';
import 'components/add_project.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.5,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: kBackgroundColor
              ),
                currentAccountPicture: CachedNetworkImage(
                  imageUrl: '${_auth.currentUser!.photoURL!}',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                accountName: Text(_auth.currentUser!.displayName!, style: const TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),),
                accountEmail: Text(_auth.currentUser!.email!, style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                ),)),
            ListTile(
              title: const Text('Logout', style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),),
              trailing: const Icon(Icons.logout, color: kPrimaryColor,),
              onTap: () {
                Authenticator().signout(context);
              },
            ),
          ],
        ),
      ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          print('asdas');
                          _key.currentState!.openDrawer();
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Color(0XFF263064),
                        )),
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
                                text:
                                    " ${DateFormat('dd MMM').format(DateTime.now())}",
                                style: const TextStyle(
                                    color: Color(0XFF263064),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "${_auth.currentUser!.photoURL}",
                      imageBuilder: (context, imageProvider) => Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.2),
                              blurRadius: 12,
                              spreadRadius: 8,
                            )
                          ],
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi ${_auth.currentUser!.displayName}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
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
                    TitleRow(
                      title: 'YOUR PROJECTS',
                      number: 3,
                    ),
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
