import 'package:flutter/material.dart';

class ListTrainers extends StatefulWidget {
  @override
  _ListTrainersState createState() => _ListTrainersState();
}

class _ListTrainersState extends State<ListTrainers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Treinadores"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
