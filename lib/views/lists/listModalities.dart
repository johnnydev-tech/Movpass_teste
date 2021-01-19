import 'package:flutter/material.dart';
import 'package:movpass_test/controller/modalitiesController.dart';
import 'package:movpass_test/model/modalities.dart';
import 'package:movpass_test/views/details/detailsModality.dart';

class ListModalities extends StatefulWidget {
  @override
  _ListModalitiesState createState() => _ListModalitiesState();
}

class _ListModalitiesState extends State<ListModalities> {
  ModalityAPI api = ModalityAPI();

  _listModality() {
    return api.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modalidades"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<Modalities>>(
          future: _listModality(),
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
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List<Modalities> lista = snapshot.data;
                      Modalities modality = lista[index];

                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                                scale: 1,
                                image: AssetImage(
                                    modality.id == 1
                                        ? "assets/treinoFunc.webp"
                                        : modality.id == 2
                                        ? "assets/hiit.webp"
                                        : modality.id == 3
                                        ? "assets/alongamento.webp"
                                        : modality.id == 4
                                        ? "assets/avaliacao.png"
                                        : null,
                                ),
                              )
                            ),
                          ),
                          isThreeLine: true,
                          trailing: Icon(
                            Icons.more_vert,
                          ),
                          title: Text(
                            modality.label,
                          ),
                          subtitle: Text(
                            modality.description,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DetailModality(
                                          id: modality.id,
                                        )));
                          },
                        ),
                      );
                    },
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
