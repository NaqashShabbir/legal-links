import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  // Get function for map
  Future getMap({
    String? url,
    Function(String)? onSuccess,
    Function(String)? onError,
  }) async {
    try {
      debugPrint("this is get Url: $url");

      var response = await http
          .get(
        Uri.parse(url!),
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw Exception("Request Time Out");
      });
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        onSuccess?.call(response.body);
      } else if (response.statusCode == 204) {
        onError?.call(response.body);
      } else if (response.statusCode == 404) {
        onError?.call(response.body);
      } else {
        log("i am in error  ${response.body}");
        onError?.call(response.body);
      }
    } on SocketException catch (e) {
      log("i am in error catch ${e.toString()}");
      onError?.call("Unable to establish connection to server.");
    } on TimeoutException catch (e) {
      log("i am in error catch ${e.toString()}");
      onError?.call("Request timed out.");
    } on HttpException catch (e) {
      log("i am in error catch ${e.toString()}");
      onError?.call("HTTP error occurred: ${e.message}");
    } on http.ClientException catch (e) {
      log("i am in error catch ${e.toString()}");
      onError?.call("Client error occurred: ${e.message}");
    } on ArgumentError catch (e) {
      log("i am in error catch ${e.toString()}");
      onError?.call("Invalid argument: ${e.message}");
    } on FormatException catch (e) {
      log("i am in error catch ${e.toString()}");
      onError?.call("Invalid format: ${e.message}");
    } catch (e) {
      log("i am in error catch ${e.toString()}");
      onError?.call("Unknown error occurred: ${e.toString()}");
    }
  }
}
