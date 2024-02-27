

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dragondeutsch/details/flashcards_details.dart';
import 'package:dragondeutsch/model/units.dart';
import 'package:dragondeutsch/pages/achieve_screen.dart';
import 'package:dragondeutsch/pages/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';


//Declare variables
final rootNavigatorKey= GlobalKey<NavigatorState>();
final shellNavigatorHomeKey= GlobalKey<NavigatorState>(debugLabel: 'Home');
final shellNavigatorProfileKey= GlobalKey<NavigatorState>(debugLabel: 'Profile');
final shellNavigatorAchiviementKey= GlobalKey<NavigatorState>(debugLabel: 'Achiviement');

//Create your Route
final router= GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(branches: [
        StatefulShellBranch(
          navigatorKey: shellNavigatorHomeKey,
          routes: [
            GoRoute(
                path: '/',
                builder: (context, state) => const HomePage(),

              ),

          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorProfileKey,
          routes: [
            GoRoute(
                path: '/achieve',
                builder: (context, state) => const AchieveScreen())
    
          ],

        ),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/profile',
              builder:(context,state)=> const ProfileScreen(),
            ),
        ])
      ],
      builder: (context, state, navigationShell) {
        return ScaffoldWithBottomBar(navigationShell: navigationShell);
      },
    )
  ],
);

class AppSettings extends ChangeNotifier {
  bool detailsEnabled = false;

  void toggleDetailsEnabled(bool value) {
    detailsEnabled = value;
    notifyListeners();
  }
}

class ScaffoldWithBottomBar extends StatefulWidget {
  const ScaffoldWithBottomBar({Key? key, required this.navigationShell})
      : super(key: key);
  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() {
    return _ScaffoldWithBottomBarState();
  }
}

class _ScaffoldWithBottomBarState extends State<ScaffoldWithBottomBar> {
  @override
  Widget build(BuildContext context) {
    double currentWidth=MediaQuery.of(context).size.width;
    return Scaffold(

      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: Colors.red[900],
        onTap: _changeTab,
        currentIndex: widget.navigationShell.currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: currentWidth < 600? 20:50 ), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.archive_rounded,size: currentWidth < 600? 20:50 ), label: 'Achieve'),
          BottomNavigationBarItem(icon: Icon(Icons.person,size: currentWidth < 600? 20:50 ), label: 'Profile'),
        ],
      ),
    );
  }

  void _changeTab(int value) {
    widget.navigationShell.goBranch(value,
        initialLocation: value == widget.navigationShell.currentIndex);
    }
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<AppSettings>(
      create: (_) => AppSettings(),
      child: MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      )
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user; // Declare user variable
  String? firstName; // Declare variable to store user's first name

  // Obtain data of the user
  List<String> docIDs = [];

  Future<void> getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then(
      (snapshot) => snapshot.docs.forEach(
        (document) {
          print(document.data());
          docIDs.add(document.reference.id);
        },
      ),
    );
  }

  Future<void> getUserData() async {
    // Get current user
    user = FirebaseAuth.instance.currentUser!;

    // Get user document
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

  }
  @override
  void initState() {
    getUserData();
    getDocId();
    super.initState();
  }
  
  final con = FlipCardController();
  final con1 = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(400, 90)),
                  color: Color.fromARGB(255, 157, 43, 35),)),
              const Column(
                children: [
                  SizedBox(height: 90,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('Hi! ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white))],),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('What vocabulary would you like to learn? ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white))],),
                  ),
                ],
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:25.0),
              child: Container(
                height: 600,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: listUnitsChild.length,
                  itemBuilder: (BuildContext context, index){
                    return InkWell( 
                      //borderRadius: BorderRadius.circular(10),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> FlashCardsDetails(unit: listUnitsChild[index],)));
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle, // Set the shape to circle
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(listUnitsChild[index].imagePath!),
                              radius: 25, // Adjust the radius as needed
                            ),
                          ),
                          const SizedBox(width: 30,),
                          Text('${listUnitsChild[index].name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        ],
                      ),
                    );
                  }
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


