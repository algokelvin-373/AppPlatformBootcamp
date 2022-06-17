import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieTabWidget extends StatefulWidget {
  final String url;

  const MovieTabWidget(this.url, {Key? key}) : super(key: key);

  @override
  _MovieTabState createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTabWidget> {
  late String apiUrl;

  @override
  initState(){
    apiUrl = widget.url;
  }

  Future<List<dynamic>> fetchDataUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 10,
                        backgroundImage:
                        NetworkImage("https://image.tmdb.org/t/p/w185/" + snapshot.data[index]['poster_path']),
                      ),
                      title: Text(snapshot.data[index]['title']),
                      subtitle: Text(snapshot.data[index]['release_date']),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}