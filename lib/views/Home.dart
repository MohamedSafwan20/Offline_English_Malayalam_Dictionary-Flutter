import 'package:flutter/material.dart';
import 'package:offline_english_malayalam_dictionary/database/db.dart';
import 'package:offline_english_malayalam_dictionary/widgets/EnglishToMalayalamList.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Column(
            children: [
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "English to Malayalam",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/malayalam');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Malayalam to English",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: EnglishToMalayalamList());
  }
}
