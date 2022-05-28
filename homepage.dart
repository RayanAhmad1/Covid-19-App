import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:main/datasource.dart';
import 'package:main/pages/countryPage.dart';
import 'package:main/panels/infoPanel.dart';
import 'package:main/panels/worldwidepanel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Map worldData;

  // ignore: prefer_typing_uninitialized_variables
  var key1;

  fetchWorldWideData()async{
    http.Response response = await http.get(Uri.parse('https://corona.lmao.ninja/v3/covid-19/all'));
    setState(() {
      worldData = json.decode(response.body);
    });
  }

    late List countryData;
    

  fetchCountryData()async{
    http.Response response = await http.get(Uri.parse('https://corona.lmao.ninja/v3/covid-19/countries'));
    setState(() {
      countryData = json.decode(response.body);
    });
  }


  @override
    void initState() {
  fetchWorldWideData();
  fetchCountryData();
  super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('COVID-19 TRACKER',),
      ),
body: SingleChildScrollView(child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Container(
          height: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          color: Colors.orange[100],
          child: Text(DataSource.quote,style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold, fontSize: 16),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Worldwide',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            GestureDetector(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountryPage()));
              },
              child: Container(
                decoration: BoxDecoration(
              color: primaryBlack,
              borderRadius: BorderRadius.circular(15)
            
                ),
                padding: const EdgeInsets.all(10),
                child:const Text('Regional',style: TextStyle(fontSize: 16, color:Colors.white, fontWeight: FontWeight.bold),)),
            ),
          ],
        ),
        ),
        
        // ignore: unnecessary_null_comparison
        worldData==null?const CircularProgressIndicator():WorldwidePanel(worldData: worldData,),
         const Padding(
          padding: EdgeInsets.symmetric(horizontal:10.0),
          child: Text('',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          // child: Text('Most Affected Countries',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 10,),
          // ignore: unnecessary_null_comparison
          // countryData==null?Container():MostAffectedPanel(key1, key1, key1: key1, countryData: countryData, key2: key1),
          const InfoPanel(),
          const SizedBox(height: 20,),
          const Center(child: Text('WE ARE TOGETHER IN THE FIGHT!', style: TextStyle(fontWeight: FontWeight.bold),)),
          const SizedBox(height: 50,)
        

  ],
      
)),
    );
  }
}