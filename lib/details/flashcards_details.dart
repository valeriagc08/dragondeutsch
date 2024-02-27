import 'package:dragondeutsch/model/units.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlashCardsDetails extends StatefulWidget {
  final Unit unit;
  const FlashCardsDetails({Key? key, required this.unit}) : super(key: key);

  @override
  State<FlashCardsDetails> createState() => _FlashCardsDetailsState();
}

class _FlashCardsDetailsState extends State<FlashCardsDetails> {
  late FlipCardController con1; // Declare FlipCardController instance

  @override
  void initState() {
    super.initState();
    con1 = FlipCardController(); // Initialize FlipCardController
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 700,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlipCard(
                          rotateSide: RotateSide.bottom,
                          axis: FlipAxis.horizontal,
                          controller: con1,
                          frontWidget: Center(
                            child: Container(
                              height: 350,
                              width: 350,
                              child: Image.asset(
                                'assets/images/b1.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          backWidget: Center(
                            child: Container(
                              height: 350,
                              width: 350,
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          child: const Text('Flip Bottom'),
                          onPressed: () {
                            // Flip the card programmatically
                            con1.flipcard();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
