 
import 'dart:convert';
import 'dart:core';
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 


Future? callService(Uri uri, String method, String action, Map<String, dynamic> params) async {
  
  //Certificado para acesso sem HTTPS
  HttpClient client = HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
 
  http.Response? response;

  const Map<String, String> headers = {
    "content-type": "application/json"
  };

  String errorMessage = "";
  bool hasError = false;

  switch (method.toUpperCase()) {
    case 'POST' :
      try {
        response = await http.post(
          uri,
          body: params
        );
      } catch(e) { 
        hasError = true;
        errorMessage = e.toString();
      }
    break;
    case 'GET':
      try{
        response = await http.get( 
          uri, 
          headers: headers 
        );  
      } catch(e) { 
        hasError = true;
        errorMessage = e.toString();
      }
    break;
  }

  if (hasError == true) {
    debugPrint("Internet error:");
    debugPrint(errorMessage);
    return;
  }
    
  try{ 
    if(response!.statusCode == 200) { 
      return jsonDecode(response.body);
    }  
  } catch (e) { 
    return null;
  }

  return null;
}