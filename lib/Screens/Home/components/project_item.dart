import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:take_home/providers/Firebase/authentication/firebase_auth.dart';
import 'package:take_home/utils/constants.dart';

import '../../board_screen/board_screen.dart';

class BuildProjectItem extends StatefulWidget {
  final data;
  const BuildProjectItem({Key? key, this.data}) : super(key: key);

  @override
  State<BuildProjectItem> createState() => _BuildProjectItemState();
}

class _BuildProjectItemState extends State<BuildProjectItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => KanbanBoard(title: widget.data['name'], id: widget.data.id, description: widget.data['description'])));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9FB),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${DateFormat('dd').format(widget.data['createdAt'].toDate())}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${DateFormat('MMM').format(widget.data['createdAt'].toDate())}",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
            Container(
              height: 100,
              width: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 160,
                  child:  Text(
                    "${widget.data['name']}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.description,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Text(
                        "${widget.data['description']}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: "${Authenticator().auth.currentUser!.photoURL}",
                      imageBuilder: (context, imageProvider) => Container(
                        height: 20,
                        width: 20,
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
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${Authenticator().auth.currentUser!.displayName!}",
                      style: TextStyle(color: Colors.grey, fontSize: 13, fontFamily: 'Montserrat'),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
