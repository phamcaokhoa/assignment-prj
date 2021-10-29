import 'dart:io';
import 'package:bookingpitch5/models/user_accounts/user_account.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  HttpClient client = HttpClient();
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    LoginResponseModel responseModel;
    // String link = "https://10.0.2.2:44322/";

    String link = "https://104.215.186.78/";
    String url = link + "api/v1/user-accounts/login";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username' : loginRequestModel.username,
        'password' : loginRequestModel.password,
      }),
    );

    if(response.statusCode == 200 || response.statusCode == 400){
       responseModel = LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception(Exception);
    }
    return responseModel;
  }
}