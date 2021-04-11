
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_restuarant/display.dart';
import 'package:flutter_application_restuarant/fav.dart';
import 'package:flutter_application_restuarant/restaurant.dart';
import 'package:flutter_application_restuarant/search.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv; 

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://developers.zomato.com/api/v2.1/search',
      headers: {
        'user-key': DotEnv.env['ZOMATO_API_KEY'],
        },
      ));

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String query;
  List<String> fav = List<String>();
  Future<List> searchRestaurant(String query) async {
    final response = await widget.dio.get('',
    queryParameters: {
      'q':query,
    },);
    //print(response.data['restaurants']);
    return response.data['restaurants'];      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(icon:Icon(Icons.favorite_border), onPressed:()=> pushtofav(context))
        ],
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 2,
        //shape: RoundedRectangleBorder(
        //  borderRadius: BorderRadius.circular(10)
        //),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start ,
          children: <Widget>[
            SearchForm(onSearch : (q){
              setState(() {
                query = q;
              });
            }),
            SizedBox(height: 10,),
            query == null 
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.black12,
                  size: 120,
                ),
                Text("No result to display",
                style: TextStyle(color: Colors.black12,fontSize:15 ),)
              ],
            ): 
            FutureBuilder(future: searchRestaurant(query),
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if (snapshot.hasData){
                return Expanded(child:ListView(
                  children: snapshot.data.map<Widget>((json) => RestaurantItem(Restaurant(json),fav)
              ).toList(),
            ),
            );
            }
            return Text('Error retrieving results : ${snapshot.error}');
            },
            ) 
          ],
        ),
      ),
    ); 
  }
  Future pushtofav(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => Favourite(
          favRestaurants: fav,
        ),
      ),
    );
  }
}