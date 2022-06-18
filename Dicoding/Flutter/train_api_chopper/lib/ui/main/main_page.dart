import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_api_chopper/model/movie.dart';
import 'package:train_api_chopper/service/api_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => ApiService.create(),
        dispose: (_, ApiService service) => service.client.dispose(),
        child: MaterialApp(
          title: 'Flutter API Chopper',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter API Chopper'),
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar GET HTTP'),
      ),
      body: _buildBody(context),
    );
  }

  FutureBuilder<Response<ListMovie>> _buildBody(BuildContext context) {
    return FutureBuilder<Response<ListMovie>>(
      future: Provider.of<ApiService>(context).getMoviePopular("19978af3bb16e019522fd5077f3018f2", "en-US"),
      builder: (context, snapshot) {
        print("Data => ${snapshot.requireData.body.toString()}");
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          } else {
            return Center(
              child: Text(
                snapshot.requireData.body.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          // final popular = snapshot.data?.body;
          // return _buildListMovie(context, popular);
        } else {
          // Show a loading indicator while waiting for the movies
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildListMovie(BuildContext context, ListMovie? listMovie) {
    const String IMAGE_URL = "https://image.tmdb.org/t/p/w185/";

    return ListView.builder(
        itemCount: listMovie?.data?.length,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  IMAGE_URL + (listMovie?.data?[index]?.poster ?? 'empty')),
                              fit: BoxFit.contain)),
                    ),
                    Expanded(
                        child: Container(
                          height: 200,
                          child: Column(
                            children: <Widget>[
                              Text(
                                listMovie?.data?[index]?.title ?? 'empty',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Expanded(
                                  child: Container(
                                      child: Text(
                                        listMovie?.data?[index]?.overview ?? 'empty',
                                        style: TextStyle(fontSize: 12),
                                      )
                                  )
                              ),
                            ],
                          ),
                        ),
                    )
                  ],
                ),
            ),
          );
        }
    );
  }
}
