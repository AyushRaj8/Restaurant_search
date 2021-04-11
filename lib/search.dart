import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  SearchForm({this.onSearch});
  final void Function(String search) onSearch;
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formkey = GlobalKey<FormState>();
  final _ctrl = TextEditingController();
  var _autoValidate = false;
  var _search;
  @override
  Widget build(BuildContext context) {
    return Form(
                key: _formkey,
                autovalidate: _autoValidate,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        //labelText: 'Enter search',
                        hintText: 'Search',
                        border: OutlineInputBorder(),
                        filled: true,
                        errorStyle: TextStyle(fontSize: 15),
                      ),
                      controller: _ctrl,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value){
                          _search = value;
                      },
                      validator: (value){
                        if (value.isEmpty){
                          return "Please enter to search";
                        }
                        return null;
                      },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 110,
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius : BorderRadius.circular(10)),
                          onPressed: (){
                            if(_formkey.currentState.validate())
                              widget.onSearch(_search);
                            else{
                              setState(() {
                                _autoValidate = true;
                              }); 
                            }
                          },
                          fillColor: Colors.red,
                          //tooltip: 'Search',
                          child: Text("SEARCH",style:TextStyle(color: Colors.white,fontSize: 20,fontFamily:"Aerial"),
                        ),
                      ),
                    ),
                  ],),);
  }
}