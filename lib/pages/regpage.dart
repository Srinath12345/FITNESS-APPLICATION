import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_calculator/SQL/sqlutil.dart';
import 'package:macro_calculator/pages/login.dart';
import 'package:macro_calculator/widgets/tile.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State {
  String uname = "";
  String pass = "";
  String conpass = "";
  final statuskey = GlobalKey<FormState>();
  late bool state;
  // ignore: non_constant_identifier_names
  final TextEditingController pas_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController conpas_controller = TextEditingController();

  Widget buildusername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'username',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        TextFormField(
          validator: (value){
            if (value!.isEmpty || !RegExp(r'^[a-zA-Z0-9]{6,20}').hasMatch(value)){
              return 'Enter correct username';
            }
            return null;
          },
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.email, color: Color(0x66000000)),
              hintText: "Username",
              hintStyle: TextStyle(color: Colors.white)),
          onChanged: (value) {
            setState(() {
              uname = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          validator: (value){
            if (value!.isEmpty || !state){
              return 'Enter correct password';
            }
            return null;
          },
          controller: pas_controller,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.lock, color: Color(0x66000000)),
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.white)),
          onChanged: (value) {
            setState(() {
              pass = value;
            });
          },
        ),
        FlutterPwValidator(
            controller: pas_controller,
            minLength: 8,
            uppercaseCharCount: 1,
            numericCharCount: 3,
            specialCharCount: 1,
            width: 400,
            height: 150,
            onSuccess: () {
              setState(() {
                state = true;
              });},
            onFail: (){
              setState(() {
                state = false;
              });
            }
        )
      ],
    );
  }

  Widget buildconfirmpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'confirm password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty || !state || !(pass == conpass)) {
              return 'Enter correct password';
            }
            return null;
          },
          controller: conpas_controller,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.lock, color: Color(0x66000000)),
              hintText: "Confirm Password",
              hintStyle: TextStyle(color: Colors.white)),
          onChanged: (value) {
            setState(() {
              conpass = value;
            });
          },
        ),
        FlutterPwValidator(
            controller: conpas_controller,
            minLength: 8,
            uppercaseCharCount: 1,
            numericCharCount: 2,
            specialCharCount: 1,
            width: 400,
            height: 150,
            onSuccess: () {
              setState(() {
                state = true;
              });},
            onFail: (){
              setState(() {
                state = false;
              });
            }
        )
      ],
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    elevation: 10,
    foregroundColor: Colors.white,
    backgroundColor: Colors.grey[300],
    padding: const EdgeInsets.all(15),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  Widget buildRegisterBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          if (statuskey.currentState!.validate() && state) {
            SQLhelper.createitem(uname, pass);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Login()));
          }
        },
        child: const Text(
          'REGISTER',
          style: TextStyle(

              color: Color(0xff000000),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Form(
              key: statuskey,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x66000000),
                              Color(0x66000000),
                              Color(0x66000000),
                              Color(0x66000000),
                              Color(0x66000000),
                            ])),
                    child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 50),
                           Tile(child: buildusername(),
                               color: const Color(0x66999999)),

                            const SizedBox(height: 20),
                            Tile(child: buildpassword(),
                                color: const Color(0x66999999)),

                            const SizedBox(height: 20),
                            Tile(child:buildconfirmpassword(),
                                color: const Color(0x66999999)),

                            const SizedBox(height: 20),
                            buildRegisterBtn()
                          ],
                        )),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
