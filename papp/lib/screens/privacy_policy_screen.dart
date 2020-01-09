import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const routeName = '/privacy-policy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Datenschutzerklärung'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            ListTile(
              title: Text('Allgemeines'),
              subtitle: Text(
                  'Der Datenschutz ist in der Papp ein zentrales Anliegen. Hinsichtlich der Beschaffung, Bearbeitung und Nutzung der Daten untersteht die Papp der schweizerischen Datenschutzgesetzgebung.'),
              isThreeLine: true,
            ),
            ListTile(
              title: Text('Personendaten'),
              subtitle: Text(
                  'Personendaten sind alle Angaben, die sich auf eine bestimmte oder bestimmbare Person beziehen. In der Papp sind das beispielsweise die Therapie-Termine.'),
              isThreeLine: true,
            ),
            ListTile(
              title: Text('Datenherrschaft'),
              subtitle: Text(
                  'Das Recht jeglicher Daten bleibt beim Anwender. Die Daten werden nur lokal auf dem Gerät des Anwenders gespeichert.'),
              isThreeLine: true,
            ),
            ListTile(
              title: Text('Weitergabe der Daten an Dritte '),
              subtitle: Text('Die Papp gibt keine Daten an Dritte weiter.'),
              isThreeLine: true,
            ),
            ListTile(
              title: Text('Ansprüche der Anwender'),
              subtitle: Text(
                  'Anwender haben das Recht auf Auskunft. Kontaktadresse: thierrypablo.schmidt@students.bfh.ch'),
              isThreeLine: true,
            ),
          ],
        ));
  }
}
