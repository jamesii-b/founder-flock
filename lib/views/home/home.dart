import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  List<String> names = [
    'Andrews',
    'Master G',
    'Cristine',
    'Grammys',
    'Alex GH'
  ];

  @override
  void initState() {
    for (int i = 0; i < names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: names[i]),
          likeAction: () {
            actions(context, names[i], 'Liked');
          },
          nopeAction: () {
            actions(context, names[i], 'Rejected');
          },
          superlikeAction: () {
            actions(context, names[i], 'SuperLiked');
          }));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Container(
          child: Column(
            children: [
              // SizedBox(height: 70),
              Expanded(
                  child: Container(
                child: SwipeCards(
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            names[index],
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    );
                  },
                  onStackFinished: () {
                    return "";
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class Content {
  final String? text;
  Content({this.text});
}

actions(BuildContext context, String name, type) {
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });

        return AlertDialog(
          content: buttonWidget(
              type == 'Liked'
                  ? Icons.favorite
                  : type == 'Rejected'
                      ? Icons.close
                      : Icons.star,
              type == 'Liked'
                  ? Colors.pink
                  : type == 'Rejected'
                      ? Colors.red
                      : Colors.blue),
          title: Text(
            'You ${type} ${name}',
            style: TextStyle(
                color: type == 'Liked'
                    ? Colors.pink
                    : type == 'Rejected'
                        ? Colors.red
                        : Colors.blue),
          ),
        );
      });
}

Widget buttonWidget(IconData icon, Color color) {
  return Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: color)),
    child: Icon(
      icon,
      color: color,
      size: 30,
    ),
  );
}

List images = [
  'assets/image1.jpeg',
  'assets/image2.jpeg',
  'assets/image3.png',
  'assets/image4.jpeg',
  'assets/image5.jpg'
];
