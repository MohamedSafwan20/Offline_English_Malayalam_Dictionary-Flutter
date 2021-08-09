import 'dart:async';

import 'package:flutter/material.dart';
import 'package:offline_english_malayalam_dictionary/database/db.dart';
import 'package:offline_english_malayalam_dictionary/widgets/Loading.dart';

class MalayalamToEnglishList extends StatefulWidget {
  const MalayalamToEnglishList({Key? key}) : super(key: key);

  @override
  _MalayalamToEnglishListState createState() => _MalayalamToEnglishListState();
}

class _MalayalamToEnglishListState extends State<MalayalamToEnglishList> {
  // ignore: close_sinks
  StreamController streamController = StreamController();

  List refactoredData = [];

  getDictionaryData() async {
    return await DictionaryDatabase.instance.getMalayalamWordsWithDefinition();
  }

  filterWords(String text, List data) {
    List filteredWords =
        data.where((item) => item['malayalam_word'].startsWith(text)).toList();
    streamController.sink.add(filteredWords);
  }

  refactorData(List dictionaryData) {
    List list;
    dictionaryData.forEach((item) {
      list = item['malayalam_word'].split(";");
      list.forEach((element) {
        refactoredData.add(
            {"malayalam_word": element, "english_word": item['english_word']});
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDictionaryData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            refactorData(snapshot.data);
            return Column(
              children: [
                TextField(
                  onChanged: (text) {
                    filterWords(text, refactoredData);
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
                      initialData: refactoredData,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    shape: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 0.1),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data[index]
                                            ['malayalam_word']),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            snapshot.data[index]
                                                ['english_word'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ));
                              });
                        }
                        return Loading();
                      }),
                ),
              ],
            );
          }
          return Loading();
        });
  }
}
