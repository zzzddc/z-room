import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_5020_exercise/login.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
void main() => runApp(AbizApp ());
class User {
  String username;
  String pwd;
  User(this.username, this.pwd);
}

class AbizApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute:(settings){
        if(settings.name == LoginVerifyHome.routeName)
        {
          User user = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => LoginVerifyHome
                (
                 pageContext: context,
                 name: user.username,
                 pwd : user.pwd
                )
          );
        }
      } ,
      title: '5020',
      theme: ThemeData(
      ),
      home: LoginPage(),
      routes: <String,WidgetBuilder>{
        "app": (BuildContext context) => LoginVerify(),
      }
    );
  }
}
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}
 Future <Uint8List> _getYzm() async{
  var res = await http.get("https://xigualab.net/test/5020homework/captcha");
  Uint8List body = res.bodyBytes;
  return body;
}
class _LoginPageState extends State<LoginPage> {
  // var pic;
  // _getYzm() async{
  //   Dio _dio=Dio();
  //   var res = await _dio.get("https://xigualab.net/test/5020homework/captcha");
  //   var data= jsonDecode(res.toString());
  //   var result = data;
  //   // Uint8List body = res.bodyBytes;
  //   setState(() {
  //    pic= result;//4
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    FocusNode _uNameNode = FocusNode();
    FocusNode _pwdNode = FocusNode();

    var _unameController = new TextEditingController();
    var _upwdController = new TextEditingController();
    var _yzmController = new TextEditingController();
    GlobalKey _formKey = new GlobalKey<FormState>();
    return Scaffold(
      appBar: new AppBar(
        title: Text('5020用户登录'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        autovalidate: false,
        onChanged: () {},
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            Container(
              child: (
                  TextFormField(
                    autofocus: true,
                    controller: _unameController,
                    validator: (str) {
                      return str
                          .trim()
                          .length > 0 ? null : "用户名不能为空";
                    },
                    decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "用户名或邮箱",
                        prefixIcon: Icon(Icons.person)
                    ),
                  )
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: _pwdNode.hasFocus ? Colors.black : Colors.grey,
                          width: 0.5
                      )
                  )
              ),
            ),
            Container(
              child: TextFormField(
                autofocus: true,
                controller: _upwdController,
                validator: (str) {
                  return str
                      .trim()
                      .length > 5 ? null : "密码不能小于六位";
                },
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "密码5~16位中文或英文",
                    prefixIcon: Icon(Icons.https)
                ),
                obscureText: true,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: _pwdNode.hasFocus ? Colors.black : Colors.grey,
                          width: 0.5
                      )
                  )
              ),
            ),
            TextFormField(
                  autofocus: true,
                  controller: _yzmController,
                  decoration: InputDecoration(
                    labelText: "验证码",
                  ),
                ),
            FutureBuilder<Uint8List>(
                    future: _getYzm(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      return Image.memory(snapshot.data);
                    }

            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            //   child :Row(
            //
            //  ),
            // ) ,
            Padding(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      //传递用户名密码参数
                      onPressed: () async {
                        if((_formKey.currentState as FormState).validate()){
                         var url = 'https://xigualab.net/test/5020homework/login';
                         var result =await http.post(url,body: {'userid':_unameController.text,'pwd':_upwdController.text,'captcha':_yzmController.text});
                         print(result.body);
                         // Navigator.pushNamed(
                          //   context,
                          //   LoginVerifyHome.routeName,
                          //   arguments: User(_unameController.text,_upwdController.text),
                          // );
                          //print("用户名是"+_unameController.text+"密码是"+_upwdController.text);
                        }
                      },
                      child: Text('登录'),
                      color: Theme
                          .of(context)
                          .primaryColor,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );
  }

}

