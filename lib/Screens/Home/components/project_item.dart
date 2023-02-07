import 'package:flutter/material.dart';

class BuildProjectItem extends StatefulWidget {
  const BuildProjectItem({Key? key}) : super(key: key);

  @override
  State<BuildProjectItem> createState() => _BuildProjectItemState();
}

class _BuildProjectItemState extends State<BuildProjectItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: const [
              Text(
                "07:00",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "AM",
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
                child: const Text(
                  "The Basic of Typography II",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: const Text(
                      "Room C1, Faculty of Art & Design Building",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=80"),
                    radius: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Gabriel Sutton",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
