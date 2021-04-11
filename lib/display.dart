import 'package:flutter/material.dart';
import 'package:flutter_application_restuarant/restaurant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class RestaurantItem extends StatefulWidget {
  final Restaurant restaurant;
  RestaurantItem(this.restaurant,this.res);
  List <String> res = List<String>();

  @override
  _RestaurantItemState createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        //forceSafariVC: false,
        //forceWebView: false,
        //headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  List<String> favres = List<String>();
  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                widget.restaurant.thumbnail!=null && widget.restaurant.thumbnail.isNotEmpty ?
                Ink(
                  height:100,
                  width: 55,
                  decoration: BoxDecoration(color: Colors.blueGrey,
                  image: DecorationImage(
                    fit:BoxFit.cover,
                    image: NetworkImage(widget.restaurant.thumbnail),
                  ),
                  ),
            )
            :Container(
              height: 100,
              width: 55,
              color: Colors.blueGrey,
              child: Icon(
                Icons.restaurant,
                size: 20,
                color: Colors.white,
              ),
            ),
            Flexible(child:Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.restaurant.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on,
                        color: Colors.redAccent,
                        size: 15,),
                        Text(widget.restaurant.locality),
                        ],),
                  Text("${widget.restaurant.reviews} reviews"),
                  ListTile(
                      title:widget.restaurant.rating != "" 
                      ? FlutterRatingBarIndicator(
                      rating : double.parse(widget.restaurant.rating),
                      itemCount: 5,
                      itemSize: 20,
                      fillColor: Colors.amber,
                      emptyColor: Colors.blueGrey,
                        )
                      :Text('No ratings'), 
                      subtitle:FlatButton(
                        child: Text('View'),
                        color: Colors.red,
                        minWidth:5 ,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        onPressed:()=> _launchInBrowser(widget.restaurant.url),
                      ),
                      trailing: Icon(
                        favres.contains(widget.restaurant.name) ? Icons.favorite : Icons.favorite_border,color: favres.contains(widget.restaurant.name) ? Colors.red : null,
                        ),
                        onTap: (){
                          setState(() {
                            if (favres.contains(widget.restaurant.name)){
                              favres.remove(widget.restaurant.name);
                              widget.res.remove(widget.restaurant.name);
                            }
                            else{
                              favres.add(widget.restaurant.name);
                              widget.res.add(widget.restaurant.name);
                            }
                          });
                        },
                  ),
                ],
              ),
            ),
            ),
          ],
      ),),
    );
    }

}