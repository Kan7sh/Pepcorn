import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pepcornsllp/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> cryptoData = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        cryptoData = data; // Assign the fetched data to cryptoData
      });
    }).catchError((error) {
      print('Failed to fetch data: $error');
    });
  }
  void logout()async{
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("login", false);
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const LoginScreen()) );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse('https://api.coinpaprika.com/v1/tickers'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color:const Color(0xff112D4E),
        child: Column(
          children: [
            const SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "TOP CRYPTO CURRENCIES",
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 30,
                    width: 90,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 4,
                            primary:const Color(0xffDBE2EF),
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                        onPressed: ()=>logout(),
                        child:const Text("LOGOUT",style: TextStyle(color: Colors.black,fontSize: 15,),)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8,),
            const Divider(color: Colors.white,),
            const ListTile(
              leading: Text("Rank",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
              title: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text("Currency",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
              ),
              trailing: Text("Price",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
            ),
            const Divider(color: Colors.white,),
            cryptoData.isEmpty
            ?const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(child: CircularProgressIndicator(),),
            )
            :Expanded(
              child: ListView.builder(
                itemCount: cryptoData.length,
                itemBuilder: (BuildContext context, int index) {
                  final crypto = cryptoData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)
                      ),
                      color: const Color(0xffB0C7E2),
                      child: ListTile(
                        leading: Text(crypto['rank'].toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(crypto['name'].toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        subtitle: Text(crypto['symbol'].toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),),
                        trailing: Text('\$${crypto['quotes']["USD"]["price"].toString().substring(0,7)}',style: const TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

  }
}
