// unsounding dart null safety
// @dart=2.9

import 'dart:async';

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

  StreamController streamController = StreamController();

  getDictionaryData() async {
    return await DictionaryDatabase.instance.getEnglishWords();
  }

  filterWords(String text, List data) {
    List filteredWords =
        data.where((f) => f['english_word'].startsWith(text)).toList();
    streamController.sink.add(filteredWords);
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
            // englishWords = snapshot.data;
            return Column(
              children: [
                TextField(
                  onChanged: (text) {
                    filterWords(text, snapshot.data);
                  },
                  decoration: InputDecoration(
                      fillColor: Theme.of(context).primaryColorLight,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Search..'),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: streamController.stream,
                      initialData: snapshot.data,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: () {},
                                    shape: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 0.1),
                                    title: Text(
                                        snapshot.data[index]['english_word']));
                              });
                        }
                        return Text("data");
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
