import 'package:flutter/material.dart';
import 'package:moga_app/ui/movie/movie_tab_page.dart';
import 'package:moga_app/ui/profile/page_profile.dart';

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
    MovieTabWidget("https://api.themoviedb.org/3/movie/now_playing?api_key=19978af3bb16e019522fd5077f3018f2&language=en-US"),
    MovieTabWidget("https://api.themoviedb.org/3/movie/now_playing?api_key=19978af3bb16e019522fd5077f3018f2&language=en-US"),
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
