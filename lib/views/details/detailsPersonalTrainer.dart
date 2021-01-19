import 'package:flutter/material.dart';
import 'package:movpass_test/controller/trainerController.dart';
import 'package:movpass_test/model/modalities.dart';
import 'package:movpass_test/model/trainer.dart';
import 'package:movpass_test/views/lists/listModalities.dart';

class DetailTrainer extends StatefulWidget {
  final int id;

  const DetailTrainer({Key key, this.id}) : super(key: key);

  @override
  _DetailTrainerState createState() => _DetailTrainerState();
}

class _DetailTrainerState extends State<DetailTrainer> {
  TrainerAPI api = TrainerAPI();

  _getTrainer() {
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
          future: _getTrainer(),
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
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xffE9A945),
                              Color(0xffE9A945).withOpacity(.7)
                            ]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Material(
                                  elevation: 5.0,
                                  shape: CircleBorder(),
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xffF9F9F9),
                                    radius: 40.0,
                                    child: Icon(
                                      Icons.account_circle_rounded,
                                      size: 80.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(
                                            trainer.name,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            trainer.email,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "CREF",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            trainer.cref,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Modalidades",
                                    style: TextStyle(
                                        color: Color(0xff242A2C),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18),
                                  ),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    (ListModalities())));
                                      },
                                      child: Text("Ver Todas"))
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: trainer.modalities.length,
                                itemBuilder: (context, index) {
                                  List<Modalities> list = trainer.modalities;
                                  Modalities modalidade = list[index];
                                  print(modalidade.toString());

                                  return Card(
                                    child: ListTile(
                                      title: (Text(modalidade.label)),
                                      subtitle: Row(
                                        children: [
                                          Text("Duração: ",
                                              style: TextStyle(
                                                color: Color(0xff242A2C),
                                                fontWeight: FontWeight.w300,
                                              )),
                                          Text(
                                              modalidade.duration.toString() +
                                                  " min",
                                              style: TextStyle(
                                                  color: Color(0xffE9A945),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
