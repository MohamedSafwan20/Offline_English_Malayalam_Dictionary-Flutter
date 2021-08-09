import 'package:flutter/material.dart';
import 'package:offline_english_malayalam_dictionary/widgets/MalayalamToEnglishList.dart';

class MalayalamToEnglish extends StatefulWidget {
  const MalayalamToEnglish({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MalayalamToEnglishState createState() => _MalayalamToEnglishState();
}

class _MalayalamToEnglishState extends State<MalayalamToEnglish> {
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
                  Navigator.pushNamed(context, '/');
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
      body: MalayalamToEnglishList(),
    );
  }
}
