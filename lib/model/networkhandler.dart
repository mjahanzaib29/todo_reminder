import 'package:http/http.dart' as http;
import 'dart:async';

class NetworkHandler {
  // final String baseurl = "https://rocky-brushlands-19286.herokuapp.com";
  // final String endpoint = "/user/login";
  //     '{"email" :"mohammadnabeeljameel@gmail.com", "password": "asdsasdfsdf" , "name": "Nabeel" }';

  var resbody, code;

  Future<String> getSwdata() async {
    // final req = await client.getUrl(
    //     Uri.parse("https://rocky-brushlands-19286.herokuapp.com/user/login"));
    // final rspns = await req.close();
    print("future start");
    try {
      var url =
          Uri.parse('https://rocky-brushlands-19286.herokuapp.com/user/login');
      var response = await http.post(
        url,
        body:
            '{email :mohammadnabeeljameel@gmail.com, password: asdsasdfsdf , name: Nabeel }',
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      Exception exception;
    }

    return "Success";
  }
}
