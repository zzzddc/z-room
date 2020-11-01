import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginVerify extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  }
}
class LoginVerifyHome extends StatelessWidget{
  static const routeName="/LoginVerifyHome";
  BuildContext contextPage;
  String name;
  String pwd;
  LoginVerifyHome({BuildContext pageContext,this.name,this.pwd});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("C页面"),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
           },
            child: Icon(Icons.arrow_back),
          ),
      ),
      body: Center(
        child:
        Text("用户:${name}"+"密码:${pwd}"),

      ),
    );
  }

}