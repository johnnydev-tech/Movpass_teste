import 'package:flutter/material.dart';
import 'package:movpass_test/controller/modalitiesController.dart';
import 'package:movpass_test/model/modalities.dart';

class DetailModality extends StatefulWidget {
  final int id;

  const DetailModality({Key key, this.id}) : super(key: key);

  @override
  _DetailModalityState createState() => _DetailModalityState();
}

class _DetailModalityState extends State<DetailModality> {
  ModalityAPI api = ModalityAPI();

  _getModality() {
    return api.get(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes Modalidade"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: _getModality(),
          // ignore: missing_return
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xffE9A945)),
                  ),
                );
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  print("Erro ao carregar lista" + snapshot.error.toString());
                  return Center(
                    child: Text("Error"),
                  );
                } else {
                  Modalities modality = snapshot.data;
                  return Column(
                    children: [
                      Text(modality.label),
                      Text(modality.duration.toString()),
                      Text(modality.description),
                      Text(modality.id.toString()),
                      Text("Modalidades",),
                    ],
                  );
                }
                break;
            }
          },
        ),
      ),
    );
  }
}
