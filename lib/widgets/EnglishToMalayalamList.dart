// unsounding dart null safety
// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:offline_english_malayalam_dictionary/database/db.dart';

class EnglishToMalayalamList extends StatefulWidget {
  const EnglishToMalayalamList({Key key}) : super(key: key);

  @override
  _EnglishToMalayalamListState createState() => _EnglishToMalayalamListState();
}

class _EnglishToMalayalamListState extends State<EnglishToMalayalamList> {
  var dictionaryData;

  getDictionaryData() async {
    return await DictionaryDatabase.instance.getEnglishWords();
  }

  @override
  void initState() {
    super.initState();

    dictionaryData = getDictionaryData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dictionaryData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List dictionaryData = snapshot.data;
            return Column(
              children: [
                TextField(
                  onChanged: (text) {
                    dictionaryData = dictionaryData
                        .where((f) => f['english_word'].startsWith(text))
                        .toList();
                    print(dictionaryData);
                  },
                  decoration: InputDecoration(
                      fillColor: Theme.of(context).primaryColorLight,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Search..'),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: dictionaryData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () {},
                            shape: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 0.1),
                            title: Text(dictionaryData[index]['english_word']));
                      }),
                ),
              ],
            );
          }
          // TODO: implement progress
          return Container(
            child: Text('hi'),
          );
        });
  }
}
