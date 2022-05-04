import 'package:flutter/material.dart';

/*void main() {
  runApp(const MaterialApp(home: AndieSignUp2()));
}*/

class AndieSignUp2 extends StatefulWidget {
  const AndieSignUp2({Key? key}) : super(key: key);

  @override
  _AndieSignUp2State createState() => _AndieSignUp2State();
}

class _AndieSignUp2State extends State<AndieSignUp2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background1.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Row(
          children:  [
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            // color: Colors.cyanAccent,
                            child: const Image(
                              image: AssetImage(
                                'assets/andie_logo.png',
                              ),
                              width: 500,
                              height: 60,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 5,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      flex: 200,
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 5,
                              child: SizedBox(
                                width: 20,
                                height: 20,
                              )),
                          const Expanded(
                            flex: 50,
                            child: Text(
                              'WELCOME ANDIE / CLIENT',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 50,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                                  Animation secondaryAnimation)=>AndieSignUp2(),
                                  transitionDuration: Duration(seconds: 0)),
                              );
                            },
                            child: const Text('Move to page 2 new'),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


            // ------------------Right Pane Configurations-------------------

            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(50),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Text('Sign-Up as ANDIE!',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                        ),
                      ),),
                    Container(
                      margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                        ),
                      ),),
                    Container(
                      margin: const EdgeInsets.only(top:15,left: 40, right: 40),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Confirm Password',
                        ),
                      ),),

                    // BUTTON FOR GOOGLE SIGN IN
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
