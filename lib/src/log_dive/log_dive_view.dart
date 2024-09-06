import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scuba_logging_app/src/types/fish.dart';
import 'dart:convert';

class LogDiveView extends StatefulWidget {
  const LogDiveView({super.key});

  static const routeName = 'log-dive';

  @override
  State<LogDiveView> createState() => _LogDiveState();
}

class _LogDiveState extends State<LogDiveView> {
  late Future<FishResponse> futureFish;

  @override
  void initState() {
    super.initState();
    futureFish = fetchFish();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Log Dive'),
        ),
        body: FutureBuilder<FishResponse>(
          future: futureFish,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.fish.length,
                  itemBuilder: (context, index) {
                    return Text(snapshot.data!.fish[index].name);
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  Future<FishResponse> fetchFish() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8080/fish'));
    if (response.statusCode == 200) {
      return FishResponse.fromJson(
          jsonDecode(response.body) as List<dynamic>);
    } else {
      throw Exception('Failed to load fish');
    }
  }
}
