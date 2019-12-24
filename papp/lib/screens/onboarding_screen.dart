import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/onboarding.dart';
import '../widgets/teddy.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPageValue = 0;
  PageController controller = PageController();

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 14 : 8,
      width: isActive ? 14 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.amber : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: introWidgets.length,
                onPageChanged: (int page) {
                  getChangedPageAndMoveBar(page);
                },
                controller: controller,
                itemBuilder: (context, index) {
                  return introWidgets[index];
                },
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 35),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < introWidgets.length; i++)
                          if (i == currentPageValue) ...[circleBar(true)] else
                            circleBar(false),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: currentPageValue == introWidgets.length - 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: FloatingActionButton.extended(
                      label: Text(
                        'Los gehts',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        Provider.of<Onboarding>(context).setIsOnboarded(true);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Widget> introWidgets = [
  Container(
    color: Colors.teal[800],
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            //color: Colors.cyan[800],
            elevation: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 260,
              child: Teddy(),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Hey 👋',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            '"Mein Name ist Teddy und ich bin ein Eisbär. Ich lebe auf den Spitzbergen."',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: ListTile(
            title: Text(
              'Streiche von rechts nach links',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Image.asset(
              'assets/images/swipe_left.png',
              fit: BoxFit.cover,
              color: Colors.white,
            ),
            subtitle: Text(
              'Um zu sehen, wo die Spitzenbergen sind.',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    ),
  ),
  Container(
    color: Colors.teal[800],
    child: Column(
      children: <Widget>[
        Container(
          height: 300,
          width: double.infinity,
          child: Image.asset(
            'assets/images/spitzbergen_map.png',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Text(
            'Spitzbergen ist eine Insel. Die Insel ist nördlich von Europa.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: ListTile(
            title: Text(
              'Streiche von rechts nach links',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Image.asset(
              'assets/images/swipe_left.png',
              fit: BoxFit.fill,
              color: Colors.white,
            ),
            subtitle: Text(
              'Um zu erfahren, was geschah.',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    ),
  ),
  Container(
    color: Colors.teal[800],
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'Dieses Jahr durfte Teddy das erste Mal mit seiner Mutter auf die Jagd. Plötzlich kam ein Schnee-Sturm auf und Teddy verlor seine Mutter aus den Augen.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'Teddy kennt den Weg nach Hause und hat sich eine Wander-Karte gezeichnet ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: ListTile(
            title: Text(
              'Streiche von rechts nach links',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Image.asset(
              'assets/images/swipe_left.png',
              fit: BoxFit.cover,
              color: Colors.white,
            ),
            subtitle: Text(
              'Um die Wander-Karte zu sehen.',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    ),
  ),
  Container(
    color: Colors.teal[800],
    child: Column(
      children: <Widget>[
        Container(
          height: 350,
          width: double.infinity,
          child: Image.asset(
            'assets/images/teddy_footprint.png',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'Teddy ist unten auf der Insel. Er will nach oben zu seiner Familie zurück wandern.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: ListTile(
            title: Text(
              'Streiche von rechts nach links',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Image.asset(
              'assets/images/swipe_left.png',
              fit: BoxFit.cover,
              color: Colors.white,
            ),
            subtitle: Text(
              'Um zu erfahren, wie es weiter geht',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    ),
  ),
  Container(
    color: Colors.teal[800],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Text(
            'Vor dem Schnee-Sturm hat ihn seine Mutter meistens auf dem Rücken getragen. Nun muss Teddy den ganzen Weg selbst nach Hause wandern. Teddy ist aber für solch eine grosse Wanderung noch nicht fit genug.',
            style: TextStyle(
              fontSize: 20,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 45,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Text(
            'Du kannst Teddy helfen! \nIn deinen Therapien kannst du Papp-Taler und Erfahrungs-Punkte sammeln. Die Papp-Taler kannst du gegen eine Belohnung eintauschen. Mit den Erfahrungs-Punkten erhöhst du das Level von Teddy. So machst du ihn fit für die Wanderung.',
            style: TextStyle(
              fontSize: 20,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ),
  ),
];
