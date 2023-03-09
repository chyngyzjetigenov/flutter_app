import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web UI',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Web UI'),
        ),
        body: Center(
          child: ApiForm(),
        ),
      ),
    );
  }
}

class ApiForm extends StatefulWidget {
  @override
  _ApiFormState createState() => _ApiFormState();
}

class _ApiFormState extends State<ApiForm> {
  final TextEditingController _apiUrlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _response = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _apiUrlController,
            decoration: InputDecoration(
              labelText: 'API Endpoint',
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Your Name',
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              String apiURL = _apiUrlController.text;
              String name = _nameController.text;
              String url = '$apiURL?name=$name';

              try {
                final response = await http.get(Uri.parse(url));
                setState(() {
                  _response = 'Hello $name!';
                });
              } catch (error) {
                setState(() {
                  _response = 'Error: "API server"';
                });
              }
            },
            child: Text('Submit'),
          ),
          SizedBox(height: 20.0),
          Text(
            'Server Response',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                _response,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
