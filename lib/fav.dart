import 'package:flutter/material.dart';

class Favourite extends StatelessWidget {
  final List<String> favRestaurants;
  const Favourite({Key key,@required this.favRestaurants}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
      ),
      body: ListView.builder(
        itemCount: favRestaurants.length,
        itemBuilder: (BuildContext context,int index)=>ListTile(
          leading: Text('${index+1}',style: TextStyle(color: Colors.black,fontSize: 20),), //use ${} to interpolate the value of Dart expressions within strings.
          title:Text(favRestaurants[index],
          style: TextStyle(color: Colors.black,fontSize: 18),
        ),
        //subtitle: Text("query"),
        contentPadding: EdgeInsets.all(3),
        onTap: (){

        },
      ),
    ),
    );
  }
}