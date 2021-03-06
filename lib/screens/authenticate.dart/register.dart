import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prjct_andie/services/auth.dart';
import 'package:prjct_andie/testing/services(sign_in)/auth_services.dart';
import 'package:provider/provider.dart';
import '../../checkbox/checkbox_state.dart';
import '../../pages_client/client_sign_up_page.dart';

/*void main() {
  runApp( MaterialApp(home: Register()));
}*/

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

int agePerson = 0;
var tmpArray = [];
var rates = [];
double totalRate = 0.0;
double ratings = 0.0;
int report = 0;
double rateCount = 0.0;

class _RegisterState extends State<Register> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController expController = new TextEditingController();
  TextEditingController schoolController = new TextEditingController();
  TextEditingController yearsController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController fbController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String exp = '';
  String school = '';
  String years = '';
  String name = '';
  String age = '';
  String fb = '';
  String number = '';
  String error = '';

  Map<String, bool> values = {
    'PANDAY': false,
    'PLUMBER': false,
    'PAINTER': false,
    'GARDENER': false,
    'COOK': false,
    'TECHNICIAN': false,
    'ELECTRICIAN': false,
    'HOUSE KEEPER': false,
    'LAUNDERER': false,
  };

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    //tmpArray.clear();
  }

  List<String> items = [
    'Male',
    'Female',
  ];
  String? selectedItem = 'Male';
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/background1.png'),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          //------this is the app bar------
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30),
                child: const Image(
                  image: AssetImage(
                    'assets/andie_logo.png',
                  ),
                  height: 60,
                ),
              ),
              /*Expanded(
                flex: 10,
                child: Center(
                    child: ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: () {},
                )),
                */ /* SizedBox(
                        width: 20,
                        height: 20,
                      ),*/ /*
              )*/
            ],
          ),
          Expanded(
            flex: 100,
            child: Container(
              height: 500,
              width: 1500,
              margin: const EdgeInsets.fromLTRB(40, 30, 40, 30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: const AssetImage('assets/spin_gear.gif'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.dstATop),
                ),
              ),
              child: Scrollbar(
                controller: _scrollController, // <---- Here, the controller
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // color: Colors.green,
                              child: const Text(
                                'Sign up as ANDIE',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 2,
                                ),
                              ),
                              margin: const EdgeInsets.only(right: 20),
                              child: TextButton(
                                child: const Text(
                                  'Sign up as CLIENT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                                Animation animation,
                                                Animation secondaryAnimation) =>
                                            const SignUpClient(), //Change here to open Google Login
                                        transitionDuration:
                                            const Duration(seconds: 0)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          // color: Colors.green,
                          child: const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.green,
                          //padding: const EdgeInsets.only(left: 400, right: 400),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: nameController,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          if (value.length < 6) {
                                            return 'Use your complete name';
                                          } else {
                                            return null;
                                          }
                                        } else {
                                          return "Empty input";
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Name',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          if (value.contains('@') &&
                                              value.contains('.com')) {
                                            return null;
                                          } else {
                                            return 'Not a valid email';
                                          }
                                        } else {
                                          return "Empty/Invalid Email";
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Email',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          if (value.length < 6) {
                                            return 'Password is too short';
                                          } else {
                                            return null;
                                          }
                                        } else {
                                          return "Empty/Invalid Password";
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Password',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 20.0),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      error,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 14.0),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: numberController,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          if (value.length < 10) {
                                            return 'Invalid Phone No.';
                                          } else {
                                            return null;
                                          }
                                        } else {
                                          return "Empty input";
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Phone no.',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            //height: 48,
                                            child:
                                                DropdownButtonFormField<String>(
                                              dropdownColor: Colors.white,
                                              value: selectedItem,
                                              items: items
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                              /*fontWeight: FontWeight.bold*/
                                                            ),
                                                          )))
                                                  .toList(),
                                              onChanged: (item) => setState(
                                                  () => selectedItem = item),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 40, right: 40),
                                              child: TextFormField(
                                                controller: ageController,
                                                validator: (value) {
                                                  if (value!.isNotEmpty) {
                                                    if (value.contains('-') ||
                                                        value == '1' ||
                                                        value == '2' ||
                                                        value == '3' ||
                                                        value == '4' ||
                                                        value == '5' ||
                                                        value == '6' ||
                                                        value == '7' ||
                                                        value == '8' ||
                                                        value == '9' ||
                                                        value == '10' ||
                                                        value == '11' ||
                                                        value == '12' ||
                                                        value == '13' ||
                                                        value == '14' ||
                                                        value == '15' ||
                                                        value == '16' ||
                                                        value == '17') {
                                                      return 'You must be 18 or above';
                                                    } else {
                                                      return null;
                                                    }
                                                  } else {
                                                    return "Empty input";
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Age',
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: fbController,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          if (value.contains('.com')) {
                                            return null;
                                          } else {
                                            return 'Not a valid FB link';
                                          }
                                        } else {
                                          return "Empty";
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Facebook Link',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                    const SizedBox(height: 45.0),
                                  ],
                                ),
                              ),
                              Container(
                                //color: Colors.green,
                                width: 30,
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        //----------------------------------------
                        Container(
                          // color: Colors.blue,
                          child: const Text(
                            'Skills',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 10, left: 20),
                            //color: Colors.pink,
                            child: const Text(
                              'Select the skill/s that best decribes your Talents and Capabilities:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          //   color: Colors.blue,
                          width: 1200,
                          height: 180,
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 10,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 10,
                            ),
                            children: values.keys.map((String key) {
                              return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(key),
                                value: values[key],
                                activeColor: Colors.pink,
                                checkColor: Colors.white,
                                onChanged: (bool? value) async {
                                  setState(() {
                                    values[key] = value!;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          //   color: Colors.green,
                          child: const Text(
                            'Bio',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 10, left: 20),
                            //   color: Colors.pink,
                            child: const Text(
                              'Hey ANDIE! Let us write your Bio! This will help us easily create your Profile.',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 15, left: 20, right: 25),
                          //color: Colors.green,
                          child: TextFormField(
                            controller: expController,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (value.length < 5) {
                                  return 'Insufficient Data';
                                } else {
                                  return null;
                                }
                              } else {
                                return "Empty input";
                              }
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  'Do you have any work experience/s? Explain it to us!',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 15, left: 20, right: 25),
                          //color: Colors.green,
                          child: TextFormField(
                            controller: schoolController,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (value.length < 5) {
                                  return 'Insufficient Data';
                                } else {
                                  return null;
                                }
                              } else {
                                return "Empty input";
                              }
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  'Did you go to any Technical Schools (ie. TESDA), Self- Taught, or something else?',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 15, left: 20, right: 25),
                          //color: Colors.green,
                          child: TextFormField(
                            controller: yearsController,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (value.length < 5) {
                                  return 'Insufficient Data';
                                } else {
                                  return null;
                                }
                              } else {
                                return "Empty input";
                              }
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  'How long have you been in this Industry?',
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            // color: Colors.red,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromRGBO(255, 205, 84, 1.0),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  final String email =
                                      emailController.text.trim();
                                  final String password =
                                      passwordController.text.trim();
                                  final String exp = expController.text.trim();
                                  final String school =
                                      schoolController.text.trim();
                                  final String years =
                                      yearsController.text.trim();
                                  final String name =
                                      nameController.text.trim();
                                  final String age = ageController.text.trim();
                                  final String fb = fbController.text.trim();
                                  final String number =
                                      numberController.text.trim();

                                  if (_formkey.currentState!.validate()) {
                                    getCheckboxItems();

                                    context
                                        .read<AuthServices>()
                                        .signUp(
                                          email,
                                          password,
                                        )
                                        .then((value) async {
                                      User? user =
                                          FirebaseAuth.instance.currentUser;

                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user?.uid)
                                          .set({
                                        "uid": user?.uid,
                                        "email": email,
                                        "password": password,
                                        "name": name,
                                        "contactNumber": number,
                                        "skills": tmpArray,
                                        "experience": exp,
                                        "school": school,
                                        "yearsOfWork": years,
                                        "age": age,
                                        "facebook": fb,
                                        "gender": selectedItem,
                                        "photo": "phto",
                                        "rateCount": rateCount,
                                        "totalRate": totalRate,
                                        "rates": rates,
                                        "ratings": ratings,
                                        "reportCount": report,
                                        "role": "andie",
                                      });
                                    });
                                  }

                                  if (email.isEmpty) {
                                    print("Email is Empty");
                                  } else {
                                    if (password.isEmpty) {
                                      print("Password is Empty");
                                    } else {}
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )

        /*Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                  )
                ),
                  validator: (val) => val!.isEmpty ? 'Enter your email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      )
                  ),
                  validator: (val) => val!.length < 6
                      ? 'Enter your password with 6 chars long'
                      : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  }),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() => error = 'Please supply a valid email');
                      }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),*/
        );
  }

  Widget buildSingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.orangeAccent,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (value) => setState(() => checkbox.value = value!),
      );
}
