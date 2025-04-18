import 'dart:io';

//  17|NOmIV0lGmx2oWP50vrfKncrv1pZyC9dIIaP9ohd3b7fa4a28

class API {
  static const baseUrl = "https://newtaxi.msarweb.net/api/v1/"; // live
  static const apiKey = "base64:v5D8qvopVTpmFLnDGjdHiyTClnPzUu600LFf3uZOHPo=";

  static Map<String, String> authheader = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    'apikey': apiKey,
  };
  static Map<String, String> header = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    'apikey': apiKey,
    'accesstoken': ''
  };

  static const userSignUP = "${baseUrl}user";
  static const categories = "categories";
}
