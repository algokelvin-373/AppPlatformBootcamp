import 'package:flutter/material.dart';
import 'package:moga_app/page_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MoGa',
      home: TabLayoutMain(),
    );
  }
}

class TabLayoutMain extends StatefulWidget {
  const TabLayoutMain({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabLayoutMainState();
  }

}

class _TabLayoutMainState extends State<TabLayoutMain> with TickerProviderStateMixin {

  late TabController _tabController;

  static const List<Tab> _tabs = [
    Tab(icon: Icon(Icons.looks_one), child: Text('Movie')),
    Tab(icon: Icon(Icons.looks_two), child: Text('Game')),
  ];

  static const List<Widget> _views = [
    DataApiWidget(15),
    DataApiWidget(15),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
              indicatorWeight: 5,
              tabs: _tabs,
              indicator: BoxDecoration(
                border: Border.all(color: Colors.red),
                color: Colors.pinkAccent,
              ),
            ),
            title: const Text('MoGa'),
            actions: [
              IconButton(
                icon: Image.asset('assets/images/profile.png'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfilePage()
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.teal,
          ),
          // bottomNavigationBar: _tabs,
          body: const TabBarView(
            children: _views,
          ),
        ),
      ),
    );
  }
}

class DataApiWidget extends StatefulWidget {
  final int id;

  const DataApiWidget(this.id, {Key? key}) : super(key: key);

  @override
  _DataApiState createState() => _DataApiState();
}

class _DataApiState extends State<DataApiWidget> {
  late final int _id = widget.id;
  String apiUrl = "";

  _DataApiState() {
    apiUrl = "https://reqres.in/api/users?per_page=$_id";
  }

  Future<List<dynamic>> _fecthDataUsers() async {
    print("url $apiUrl");
    var result = await http.get(apiUrl);
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Belajar GET HTTP'),
      // ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fecthDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        NetworkImage(snapshot.data[index]['avatar']),
                      ),
                      title: Text(snapshot.data[index]['first_name'] + " " + snapshot.data[index]['last_name']),
                      subtitle: Text(snapshot.data[index]['email']),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}