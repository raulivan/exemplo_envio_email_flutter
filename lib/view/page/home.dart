import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final paraController =
      new TextEditingController(text: 'exampleo@dominio.com.br');
  final corpoController = new TextEditingController(
      text: 'Um exemplo de como enviar e-mail atraves de um app em flutter');
  final assuntoController =
      new TextEditingController(text: 'Programação para dispositivos móveis');

  Future<void> enviarEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: paraController.text,
      query:
          'subject=${assuntoController.text}&body=${corpoController.text}', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Falha ao enviar o e-mail'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enviar novo e-mail'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => enviarEmail(),
        tooltip: 'Enviar e-mail',
        child: const Icon(Icons.send_sharp),
      ),
      body: ListView(
        children: [
          // Assunto
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text('Assunto:'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: assuntoController,
            ),
          ),

          // Para
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text('Para:'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: paraController,
              keyboardType: TextInputType.emailAddress,
            ),
          ),

          // Texto
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text('Corpop do e-mail:'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: corpoController,
              maxLines: 10,
            ),
          )
        ],
      ),
    );
  }
}
