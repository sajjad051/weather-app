import 'dart:convert';

import 'package:http/http.dart' as http;
class NetworkHelper{
  final String url;

  NetworkHelper( this.url);

  getData() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      String Data = response.body;
     return jsonDecode(Data);

      //double temp = result['main']['temp'];
      //String weatherDescription = result['weather'][0]['main'];

    }
    else{
      print(response.statusCode);
    }
  }
}
