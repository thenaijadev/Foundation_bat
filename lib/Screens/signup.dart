// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, non_constant_identifier_names, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:dropdownfield2/dropdownfield2.dart';

import 'package:batnf/Screens/signin.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_text_field.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/event_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static String id = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  State<SignUp> createState() => _SignUpState();

  List<String> states = [
    'Abia State,',
    'Adamawa State',
    'Akwa Ibom State',
    'Anambara State',
    'Bauchi State',
    'Bayelsa State',
    'Benue State',
    'Borno State',
    'Cross River State',
    'Delta State',
    'Ebonyi State',
    'Edo State',
    'Ekiti State',
    'Enugu State',
    'FCT',
    'Gombe State',
    'Imo State',
    'Jigawa State',
    'Kaduna State',
    'Kano State',
    'Katsina State',
    'Kabbi State',
    'Kogi State',
    'Kwara State',
    'Lagos State',
    'Nasarawa State',
    'Niger State',
    'Ogun State',
    'Ondo State',
    'Osun State',
    'Oyo State',
    'Plateau State',
    'Rivers State',
    'Sokoto State',
    'Taraba State',
    'Yobe State',
    'Zamfara State',
  ];
  bool hidepassword = true;
  final df = DateFormat('yyyy-MM-dd');
  String selectedState = '';
  DateTime? _myDateTime;
  bool loading = false;
  bool status = false;
  final _formKey = GlobalKey<FormState>();
  void _togglePasswordView() {
    setState(() {
      hidepassword = !hidepassword;
    });
  }

  TextEditingController _firstnameTextController = TextEditingController();
  TextEditingController _lastnameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _passwordconfirmTextController =
      TextEditingController();
  TextEditingController _locationTextController = TextEditingController();
  TextEditingController _date = TextEditingController();

  late String userfirstname;
  late String userlastname;
  late String useremail;
  late String userlocation;
  late String userdob;

  Future<void> signup(
      {required String firstname,
      required String lastname,
      required String email,
      required String password,
      required String passwordconfirm,
      required String location,
      required String date}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await http.post(Uri.parse('https://www.batnf.net/api/create'),
            body: jsonEncode({
              "first_name": firstname,
              "last_name": lastname,
              "email": email,
              "password": password,
              "password_confirm": passwordconfirm,
              "location": location,
              "dob": date,
            }),
            headers: {"Content-Type": "application/json"});

    // var data = jsonDecode(response.body);
    // print(data);

    if (mounted) {
      setState(() {
        loading = false;
      });
    }

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        var username = data['last_name'];

        Provider.of<EventProvider>(context, listen: false).userName =
            username.toString();

        preferences.setString('email', email);
        preferences.setBool('autoLogin', true);
        preferences.setString('username', username.toString());
        // activate();
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: "Registration Successful\n check yor mail to activate account",
            textColor: kBackground,
            backgroundColor: kButtonColor);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      } else {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: data['message'],
            textColor: kBackground,
            backgroundColor: kButtonColor);
      }
    }

    Future<void> activate() async {
      var response = await http.get(
        Uri.parse('https://www.batnf.net/api/activatesuccess'),
      );
      var data2 = jsonDecode(response.body);
      // print(data);
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      try {
        if (response.statusCode == 200) {
          var data2 = jsonDecode(response.body);

          if (data2['status'] == 200) {
            Fluttertoast.showToast(
                fontSize: 18,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                msg: "Account Activated",
                textColor: kBackground,
                backgroundColor: kButtonColor);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignIn()));
          } else {
            Fluttertoast.showToast(
                fontSize: 18,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                msg: data2['message'],
                textColor: kBackground,
                backgroundColor: kButtonColor);
          }
        } else {
          Fluttertoast.showToast(
              fontSize: 18,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              msg: 'Service Timeout',
              textColor: kBackground,
              backgroundColor: kButtonColor);
        }
      } catch (e) {
        print(e);
      }

      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.asset(
              'assets/Bc.png',
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite,
            ),
            ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(overscroll: false),
              child: Container(
                color: Colors.white.withOpacity(0.58),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        SizedBox(height: 10),
                        // logo
                        Center(
                          child: Image.asset(
                            'assets/logo.png',
                            height: 110,
                          ),
                        ),
                        //Request for First Name
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 60.0, right: 60.0, bottom: 10.0, top: 10),
                          child: ReuseableTextField(
                            keyboard: TextInputType.name,
                            cardChild: Icon(FontAwesomeIcons.user,
                                size: 15, color: Colors.black),
                            textcontroller: _firstnameTextController,
                            label: "First Name",
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Name can not be empty"
                                  : null;
                            },
                          ),
                        ),
              
                        // Request for LastName
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 60.0, right: 60.0, bottom: 10.0),
                          child: ReuseableTextField(
                            keyboard: TextInputType.name,
                            cardChild: Icon(FontAwesomeIcons.user,
                                size: 15, color: Colors.black),
                            textcontroller: _lastnameTextController,
                            label: "Last Name",
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Name can not be empty"
                                  : null;
                            },
                          ),
                        ),
              
                        //Request for Email Address
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 60.0, right: 60.0, bottom: 10.0),
                          child: ReuseableTextField(
                            keyboard: TextInputType.emailAddress,
                            cardChild: Icon(FontAwesomeIcons.envelope,
                                size: 15, color: Colors.black),
                            textcontroller: _emailTextController,
                            label: "Email",
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Email can not be empty"
                                  : null;
                            },
                          ),
                        ),
              
                        //Request for Password
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 60.0, right: 60.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(180),
                            ),
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              validator: (val) {
                                return val!.isEmpty ? "Password is Required" : null;
                              },
                              obscureText: hidepassword,
                              controller: _passwordTextController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 2),
                                hintText: 'Password',
                                hintStyle: kTextboxhintstyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(45.0),
                                  ),
                                  borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: kTextfieldborderColor,
                                    width: 2.0,
                                  ),
                                ),
                                prefixIcon:
                                    Icon(Icons.lock, size: 15, color: Colors.black),
                                suffixIcon: IconButton(
                                  onPressed: _togglePasswordView,
                                  icon: Icon(
                                      !hidepassword
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.black,),
                                ),
                              ),
                            ),
                          ),
                        ),
              
                        //Confirm Password
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 60.0, right: 60.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(180),
                            ),
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              validator: (val) {
                                return val!.isEmpty ? "Password is Required" : null;
                              },
                              obscureText: hidepassword,
                              controller: _passwordconfirmTextController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 2),
                                hintText: 'Confirm Password',
                                hintStyle: kTextboxhintstyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(45.0),
                                  ),
                                  borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: kTextfieldborderColor,
                                    width: 2.0,
                                  ),
                                ),
                                prefixIcon:
                                    Icon(Icons.lock, size: 15, color: Colors.black),
                                suffixIcon: IconButton(
                                  onPressed: _togglePasswordView,
                                  icon: Icon(
                                    !hidepassword
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 19.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
              
                        //Request for Location
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 60.0, right: 60.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(180),
                            ),
                            child: DropDownField(
                                onValueChanged: (value) {
                                  setState(() {
                                    selectedState = value;
                                  });
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(FontAwesomeIcons.mapMarkerAlt, size: 19, color: Colors.black),
                                ),
                                itemsVisibleInDropdown: 3,
                                controller: _locationTextController,
                                hintText: "Location",
                                hintStyle: kTextboxhintstyle,
                                textStyle: kLocationTextStyle,
                                strict: false,
                                enabled: true,
                                items: states),
                          ),
                        ),
              
                        //Request for Date of Birth
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 60.0, right: 60.0, bottom: 45.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(180),
                            ),
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              onChanged: (value) {
                                userdob = value;
                              },
                              readOnly: true,
                              onTap: () async {
                                _myDateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1789),
                                  lastDate: DateTime.now(),
                                );
              
                                if (_myDateTime != null) {
                                  setState(() {
                                    _date.text = df.format(_myDateTime!);
                                  });
                                }
                              },
                              validator: (val) {
                                return val!.isEmpty
                                    ? "Date of Birth is Required"
                                    : null;
                              },
                              controller: _date,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 2),
                                hintText: 'Date of Birth',
                                hintStyle: kTextboxhintstyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(45.0),
                                  ),
                                  borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: kTextfieldborderColor,
                                    width: 2.0,
                                  ),
                                ),
                                prefixIcon: Icon(FontAwesomeIcons.calendarAlt,
                                    size: 15, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
              
                        //Sign Up Button
                        Padding(
                          padding: const EdgeInsets.only(left: 60, right: 60, bottom: 15.0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            height: 45.0,
                            color: Colors.black.withOpacity(0.26),
                            // Color.fromARGB(255, 8, 51, 121),
                            onPressed: () {
                              if (_formKey.currentState!.validate() && !loading) {
                                setState(() {
                                  loading = true;
                                });
                                signup(
                                    firstname: _firstnameTextController.text,
                                    lastname: _lastnameTextController.text,
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                    passwordconfirm:
                                        _passwordconfirmTextController.text,
                                    location: _locationTextController.text,
                                    date: _date.text);
                                activate();
                              }
                            },
                            child: loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white))
                                : Text(
                                    'Sign Up',
                                    textAlign: TextAlign.center,
                                    style: kButtontextstyle,
                                  ),
                          ),
                        ),
              
                        // Sign In Redirection
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, SignIn.id);
                              },
                              child: RichText(
                                  text: TextSpan(
                                      text: "Already have an account? ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      children: [
                                    TextSpan(
                                      text: 'Sign In',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 8, 51, 121),
                                          fontFamily: 'Inter',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                      onEnter: (event) {
                                        Navigator.pushNamed(context, SignIn.id);
                                      },
                                    )
                                  ])),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
