// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

String api = 'https://slowheftymass.bloodreaper1.repl.co/predict/';

//

//! Main API Function
var response;
bool serverRunning = true;
var result;
var displayResult = ' ';
Future<void> uploadImage(File image) async {
  var file = image.path;
  print('API Called');
  // if (image == null) return;
  http.MultipartFile multiParts = await http.MultipartFile.fromPath(
      'file', file,
      filename: file.split('/').last);
  var request = http.MultipartRequest(
    'POST',
    Uri.parse(api),
  )..files.add(multiParts);

  response = await request.send();

  if (response.statusCode == 200) {
    print('Uploaded');
    result = streamToJson(await response.stream.first);
    print(result);
    print(result['class_name']);

    //? Checking For Results To Display

    if (result['class_name'] == 'Black_rot') {
      displayResult = 'Black Rot';
    } else {
      displayResult = result['class_name'];
    }
  } else if (response.statusCode != 200) {
    serverRunning = false;
    print('Server Issue');
  } else {
    print('Image upload failed with status ${response.statusCode}');
  }
}

dynamic streamToJson(List<int> data) {
  try {
    log(data.toString());
    return const JsonDecoder()
        .convert(const Utf8Decoder().convert(data).trim());
  } catch (error, trace) {
    log("-- _streamToJson error --");
    log(error.toString());
    log(trace.toString());
    log("*****");
  }
}
