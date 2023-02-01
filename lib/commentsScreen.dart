import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'commentsModel.dart';
class commentsScreen extends StatefulWidget {
  const commentsScreen({Key? key}) : super(key: key);

  @override
  State<commentsScreen> createState() => _commentsScreenState();
}

class _commentsScreenState extends State<commentsScreen> {
  Future<List<CommentsModel>> getacomments() async {
    List<CommentsModel>model = [];
    var url = Uri.parse("uri");
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (var i in responseBody) {
      model.add(CommentsModel(postId: i["postId"], id: i["id"], name: i["name"], email: i["email"], body: i["body"])
      );
    }
    return model;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("albumsScreen"),
        centerTitle: true,
      ) ,
      body: Center(
        child: FutureBuilder(

          future: getacomments(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return (snapshot.data == null) ? CircularProgressIndicator() :
            ListView.builder(
              itemCount: snapshot.data.lengh,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: Text(snapshot.data[index].name),
                    title: Text(snapshot.data[index].email),
                    subtitle: Text(snapshot.data[index].body),

                  ),
                );
              },);
          },),
      ),
    );
  }
}
