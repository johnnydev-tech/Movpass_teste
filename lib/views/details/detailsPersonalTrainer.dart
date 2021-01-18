import 'package:flutter/material.dart';
import 'package:movpass_test/controller/trainerController.dart';
import 'package:movpass_test/model/modalities.dart';
import 'package:movpass_test/model/trainer.dart';

class DetailTrainer extends StatefulWidget {
  final int id;

  const DetailTrainer({Key key, this.id}) : super(key: key);

  @override
  _DetailTrainerState createState() => _DetailTrainerState();
}

class _DetailTrainerState extends State<DetailTrainer> {
  TrainerAPI api = TrainerAPI();

  _listTrainer() {
    return api.get(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes Treinador"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: _listTrainer(),
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
                  Trainer trainer = snapshot.data;
                  print(trainer);
                  return Column(
                    children: [
                      Text(trainer.name),
                      Text(trainer.cref),
                      Text(trainer.email),
                      Text(trainer.id.toString()),
                      Text("Modalidades",),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: trainer.modalities.length,
                        itemBuilder: (context, index) {
                          List<Modalities> list = trainer.modalities;
                          Modalities modalidade = list[index];
                          print(modalidade.toString());
                          return Card(
                            child: ListTile(
                              title: Text(modalidade.label),
                              subtitle: Text(modalidade.description),
                              leading: Text(modalidade.duration.toString()),
                              isThreeLine: true,
                            ),
                          );
                        },
                      )
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
