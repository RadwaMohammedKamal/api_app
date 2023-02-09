import 'dart:convert';
import 'package:flutter/material.dart';
import 'albumsModel.dart';
import 'package:http/http.dart' as http;
class albumsScreen extends StatefulWidget {
  const albumsScreen({Key? key}) : super(key: key);

  @override
  State<albumsScreen> createState() => _albumsScreenState();
}

class _albumsScreenState extends State<albumsScreen> {


  Future<List<albumsModel>> getalbums() async {
    List<albumsModel>model = [];
    var url = Uri.parse('');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (var i in responseBody) {
      model.add(albumsModel(userId: i["userId"],
          id: i["id"],
          title: i["title"])
      );
    }
    return model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("albumsScreen"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(

          future: getalbums(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return (snapshot.data == null) ? CircularProgressIndicator() :
            ListView.builder(
              itemCount: snapshot.data.lengh,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: Text(snapshot.data[index].postId),
                    title: Text(snapshot.data[index].title),

                  ),
                );
              },);
          },),
      ),
    );
  }
}

