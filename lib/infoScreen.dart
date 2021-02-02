import 'package:flutter/material.dart';
import 'user.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoScreen extends StatefulWidget {
  final User user;

  const InfoScreen({Key key, this.user}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

   double screenHeight, screenWidth;

    @override
    // ignore: missing_return
    Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[900],
        title: Text(
          'Cat Info',
          style: GoogleFonts.averiaSansLibre(
            color: Colors.white,
          ),
        ),
      ),


      body: Center(
        child: Column(children: <Widget>[
          Image.asset('assets/images/cat.png'),
          Text(
            "In terms of development, the first year of a cat’s life is equal to the first 15 years of a human life. After its second year, a cat is 25 in human years. And after that, each year of a cat’s life is equal to about 7 human years. Cats can rotate their ears 180 degrees. The hearing of the average cat is at least five times keener than that of a human adult. In the largest cat breed, the average male weighs approximately 20 pounds. Domestic cats spend about 70 percent of the day sleeping. And 15 percent of the day grooming. A cat cannot see directly under its nose. Most cats have no eyelashes. Cats have five toes on each front paw, but only four on the back ones. It’s not uncommon, though, for cats to have extra toes. The cat with the most toes known had 32—eight on each paw! Some believe that if you dream about a white cat, good luck will follow. Meows are not innate cat language—they developed them to communicate with humans!",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ])),
      );
    }
    
  }