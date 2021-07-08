import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/content.dart';

class ContentWidget extends StatelessWidget {
  Content content;

  ContentWidget(this.content);


  @override
  Widget build(BuildContext context) {
    return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){

                // TODO: 1. Slanje requesta za svako dugme koje se pritisne
                //       2. Konstrusati bazu tako da ima 2..3 različita polja za svako dugme, kao i za korisnike
                //       3. Nakon toga preuzeti listu mapa/pitanja/korisnika itd. u zavisnosti šta je potrebno
                //       4. Pokrenuti novi ekran u koji se prosleđuju te informacije 
                //       5. Ekran formirati u zavisnosti od pokrenutog dugmeta


                print("PROBA");
                print("OVO TAP NA CONTAINER " + content.requestURL.toString());


              },
              child: Container(
                width: double.infinity,
                height: 200.0,
                child: Center(
                    child: Text(content.name,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                decoration: BoxDecoration(
                    //color: Colors.indigo,
                    image: DecorationImage(
                        image: AssetImage(content.image), fit: BoxFit.cover)),
              ),
            ),
          ),
        );
  }
}
