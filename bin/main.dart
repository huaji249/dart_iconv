import 'dart:convert';
import 'package:iconvTest/iconv.dart' show Iconv;
import 'package:http/http.dart'as http;
main(List<String> arguments) async{
  var rep= await http.get("http://www.4399.com");
  var iconv=Iconv();
  var cont=await iconv.conv(rep.bodyBytes);
  iconv.close();
  var str=utf8.decode(cont);
  print(str);
}
