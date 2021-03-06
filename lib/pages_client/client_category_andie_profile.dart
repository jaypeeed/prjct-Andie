import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_html/html.dart' as html;
import '../pages/andie_profile_andie.dart';
import '../services/auth.dart';


final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
List<dynamic> skillsList=[];

String myName = '';
String myExp = '';
String myEdu = '';
String myYears = '';
String myGender = '';
String myAge = '';
String myEmail = '';
String myFb = '';
String myNumber = '';


class CategoryAndieProfile extends StatefulWidget {
  const CategoryAndieProfile({Key? key}) : super(key: key);

  @override
  State<CategoryAndieProfile> createState() => _CategoryAndieProfileState();
}

class _CategoryAndieProfileState extends State<CategoryAndieProfile> {
  @override
  void initState() {
    super.initState();
    _getdata();
    getSkillsList();

  }

  final AuthService _auth = AuthService();

  void _getdata() async {
    User? user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {

      setState(() {

        myName = userData.data()!['name'];
        myExp = userData.data()!['experience'];
        myEdu = userData.data()!['school'];
        myYears = userData.data()!['yearsOfWork'];
        myGender = userData.data()!['gender'];
        myAge = userData.data()!['age'];
        myEmail = userData.data()!['email'];
        myFb = userData.data()!['facebook'];
        myNumber = userData.data()!['contactNumber'];

      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(255, 205, 84, 1.0),
          title: Image.asset('assets/andie_logo.png',
            width: 180,
          ),
          elevation: 0.0,
          actions: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 65),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                        Animation secondaryAnimation)=>const AndieProfile(),
                        transitionDuration: const Duration(seconds: 0)),
                    );
                  },
                  child: const Text('Log out',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 40,
            child: Container(
              padding: const EdgeInsets.all(40),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 80,
                    child: Image.asset(
                      'assets/profile_sample.jpg',
                    ),
                  ),
                  Expanded(
                      flex: 20,
                      child: Container(
                          padding: const EdgeInsets.only(top: 40),
                          child: const Text(
                            'Set Rating SOON',
                            style: TextStyle(fontSize: 40),
                          ))),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 60,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(right: 40, bottom: 40, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child:  Text(
                        skillsList.toString(),
                        style: GoogleFonts.robotoMono(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    /////////////////////////////sdfgds//////////////////////////////////

                  ]),
                  Container(
                    padding:
                    const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      '$myName',
                      style: GoogleFonts.robotoMono(
                        fontSize:96,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    ' $myExp. $myEdu. $myYears',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30,bottom: 10),
                    child:  Text(
                      'Contact Information',
                      style: GoogleFonts.roboto(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 5, bottom: 0),
                              child: Text(
                                'Phone Number:',
                                style: GoogleFonts.roboto(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5, bottom: 0),
                              child:  Text(
                                'Gmail:',
                                style: GoogleFonts.roboto(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5, bottom: 20),
                              child: Text(
                                'Facebook:',
                                style: GoogleFonts.roboto(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(top: 5, bottom: 0),
                                child: Text(
                                  //number
                                  '$myNumber',
                                  style: GoogleFonts.roboto(
                                      fontSize: 35,
                                      color: Colors.black,
                                      /*fontWeight: FontWeight.bold,*/
                                      letterSpacing: 2.0),
                                  textAlign: TextAlign.center,
                                )),
                            Container(
                              padding: const EdgeInsets.only(top: 5, bottom: 0),
                              child: Text(
                                //email
                                '$myEmail',
                                style: GoogleFonts.roboto(
                                    fontSize: 35,
                                    color: Colors.black,
                                    /*fontWeight: FontWeight.bold,*/
                                    letterSpacing: 2.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5, bottom: 0),
                              child: Text(
                                //email
                                '$myFb',
                                style: GoogleFonts.roboto(
                                    fontSize: 35,
                                    color: Colors.black,
                                    /*fontWeight: FontWeight.bold,*/
                                    letterSpacing: 2.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () async {

                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(40,50),
                                side: const BorderSide(
                                  width: 1, color: Colors.black,
                                ),
                                primary: Color.fromRGBO(111, 215, 85, 1.0)
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child:  Text(
                                "OFFER JOB",
                                style: GoogleFonts.roboto(
                                    fontSize:21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2.0),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



  void getSkillsList() async{
    User? user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      skillsList = value.data()!["skills"];
      print(skillsList);

      final bool skillsList1 = skillsList.every((skillsList) => true);

      print(skillsList1);

      skillsList.forEach(print);

      final str = skillsList.join(' ');

      print(str);

    });

    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();


    skillsList = value.data()!["skills"];
  }
}
