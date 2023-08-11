import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_calculator/pages/home_page.dart';
import 'package:macro_calculator/pages/results_page.dart';
import 'package:macro_calculator/widgets/tile.dart';
import 'package:macro_calculator/SQL/sqlutil.dart';
import 'package:macro_calculator/pages/regpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State {
  String uname = "";
  String pass = "";
  late bool state;
  late List<Map<String, dynamic>> list;
  late int id;
  final formkey = GlobalKey<FormState>();

  Future<bool> validateUser(String user,String pswd) async {
    list = await SQLhelper.getitem();
    for (Map<String, dynamic> i in list) {
      if (i['USERNAME'] == user && i['PASSWORD'] == pswd) {
        return true;
      }
    }
    return false;
  }

  Widget buildusername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Username',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.email, color: Color(0x66000000)),
              hintText: "Username",
              hintStyle: TextStyle(color: Colors.white)),
          onChanged: (value) async{
            final check = await validateUser(uname,pass);
            setState(() {
              state = check;
              uname = value;
            });


          },
          validator: (value) {
            if (value!.isEmpty || !state) {
              return 'Enter Correct username';
            }
            return null;
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
          'Password',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.lock, color: Color(0x66000000)),
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.white)),
          onChanged: (value) async {
            final check = await validateUser(uname,pass);
            setState(() {
              state = check;
              pass = value;
            });
          },
          validator: (value) {
            if (value!.isEmpty || !state ) {
              return 'Enter correct password';
            }
            return null;
          },
        ),

      ],
    );
  }

  Widget buildregister() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Register()));
      },
      child: RichText(
        text: const TextSpan(children: [
          TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: 'Sign up',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
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

  Widget buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () async{
          state = await validateUser(uname, pass);
          if (formkey.currentState!.validate() && state) {
            SharedPreferences pref =await SharedPreferences.getInstance();
            pref.setString("user", uname);
            if (await SQLhelper.ifexists(uname)){
              var list = await SQLhelper.fetchdata(uname);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    username: uname,
                    bfper: list[0]['BF_P'],
                    totalCalories: list[0]['T_CAL'],
                    carbs: list[0]['CARB'],
                    protein: list[0]['PROTEIN'],
                    fats: list[0]['FAT'],
                    bmi: list[0]['BMI'],
                    tdee: list[0]['TDEE'],
                    bmiScale: list[0]['B_SCALE'],

                  ),
                ),
              );
            }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                      user : uname
                  ),
                ),
              );
            }

          }
        },
        child: const Text(
          'LOGIN',
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
            key: formkey,
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
                          horizontal: 25, vertical: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                          Tile(child: buildusername(),
                              color: const Color(0x66999999)),
                          Tile(child: buildpassword(),
                            color: const Color(0x66999999)),
                          const SizedBox(height: 10),
                          buildLoginBtn(),
                          buildregister(),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}