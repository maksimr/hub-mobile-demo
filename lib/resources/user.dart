import 'dart:io';
import 'dart:convert';

import 'package:meta/meta.dart';

user({
  @required hubUrl,
  @required accessToken,
  @required id,
  fields,
}) async {
  var client = new HttpClient();

  var req = await client
      .getUrl(Uri.parse("$hubUrl/api/rest/users/$id?fields=$fields"));
  req.headers.set(HttpHeaders.AUTHORIZATION, "Bearer $accessToken");

  var res = await req.close();
  return JSON.decode(await res.transform(UTF8.decoder).join());
}
