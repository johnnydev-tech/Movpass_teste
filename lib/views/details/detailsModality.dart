import 'package:flutter/material.dart';
import 'package:movpass_test/components/buttonCustom.dart';
import 'package:movpass_test/controller/modalitiesController.dart';
import 'package:movpass_test/model/modalities.dart';

class DetailModality extends StatefulWidget {
  final int id;

  const DetailModality({Key key, this.id}) : super(key: key);

  @override
  _DetailModalityState createState() => _DetailModalityState();
}

class _DetailModalityState extends State<DetailModality> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ModalityAPI api = ModalityAPI();

  _getModality() {
    return api.get(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Detalhes Modalidade"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
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
                  return ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
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
                        )),
                      ),
                      Card(
                        color: Color(0xffF9F9F9),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                child: Text(
                                  modality.id.toString(),
                                  style: TextStyle(
                                    color: Color(0xffE9A945),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                modality.label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff242A2C),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Duração:",
                                    style: TextStyle(
                                        color: Color(0xff242A2C),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    modality.duration.toString() + " min",
                                    style: TextStyle(
                                        color: Color(0xffE9A945),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                modality.description,
                                style: TextStyle(
                                    color: Color(0xff242A2C),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              ButtonCustom(
                                texto: "ESCOLHER DATA E HORA",
                                bgColor: Color(0xff242A2C),
                                onPressed: () {
                                  final snackbar = new SnackBar(
                                    content:
                                        Text("Funcionalidade em Produção!"),
                                  );
                                  _scaffoldKey.currentState
                                      .showSnackBar(snackbar);
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Divider(),
                              Text(
                                "Dúvidas? utilize o Chat ou via email:",
                                style: TextStyle(
                                  color: Color(0xffE9A945),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "contato@movpass.com.br\nSessão Online",
                                style: TextStyle(
                                    color: Color(0xff242A2C),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                "Política de Agendamento",
                                style: TextStyle(
                                  color: Color(0xffE9A945),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Os agendamentos serão abertos 10 dias antes da sessão iniciar.\n"
                                "Os agendamentos serão encerrados 8 horas antes da sessão iniciar.",
                                style: TextStyle(
                                    color: Color(0xff242A2C),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
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
