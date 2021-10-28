
import 'dart:io';

import 'dart:convert';

import '../models/pitchs/pitch_model.dart';

class PitchServce{
  HttpClient client = HttpClient();

  Future<List<PitchModel>> getListPitchByName(String searchValue) async {
    String url = "https://104.215.186.78/api/Pitches?Name=" + searchValue+"&pageIndex=1&pageSize=10";
    List<PitchModel> result = List.empty();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request =
    await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json; charset=UTF-8');
    HttpClientResponse response = await request.close();
    print(searchValue);

    if(response.statusCode == 200 ){
      List ds = jsonDecode(await response.transform(utf8.decoder).join());
      result = ds.map((e) => PitchModel.fromJson(e)).toList();
      return result;
    } else {
      return result;
    }

  }

  
}