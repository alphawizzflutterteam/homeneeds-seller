import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/AppBtn.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Home.dart';

class ChangePassPage extends StatefulWidget {

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {

  String? name,
      email,
      mobile,
      address,
      image,
      curPass,
      newPass,
      confPass,
      loaction,
      accNo,
      storename,
      storeurl,
      storeDesc,
      accname,
      bankname,
      bankcode,
      latitutute,
      longitude,
      taxname,
      taxnumber,
      pannumber,
      status,
      storelogo;

  bool _isLoading = false;
  GlobalKey<FormState> sellernameKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> addressKey = GlobalKey<FormState>();
  GlobalKey<FormState> storenameKey = GlobalKey<FormState>();
  GlobalKey<FormState> storeurlKey = GlobalKey<FormState>();
  GlobalKey<FormState> storeDescKey = GlobalKey<FormState>();
  GlobalKey<FormState> accnameKey = GlobalKey<FormState>();
  GlobalKey<FormState> accnumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> bankcodeKey = GlobalKey<FormState>();
  GlobalKey<FormState> banknameKey = GlobalKey<FormState>();
  GlobalKey<FormState> latitututeKey = GlobalKey<FormState>();
  GlobalKey<FormState> longituteKey = GlobalKey<FormState>();
  GlobalKey<FormState> taxnameKey = GlobalKey<FormState>();
  GlobalKey<FormState> taxnumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> pannumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController? nameC,
      emailC,
      mobileC,
      addressC,
      storenameC,
      storeurlC,
      storeDescC,
      accnameC,
      accnumberC,
      bankcodeC,
      banknameC,
      latitututeC,
      longituteC,
      taxnameC,
      taxnumberC,
      pannumberC,
      curPassC,
      newPassC,
      confPassC;

  bool isSelected = false, isArea = true;
  bool _isNetworkAvail = true;
  bool _showCurPassword = false, _showPassword = false, _showCmPassword = false;
  Animation? buttonSqueezeanimation;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  AnimationController? buttonController;

 // bool _showCurPassword = false, _showPassword = false, _showCmPassword = false;
   var curPassword = TextEditingController();
   var newPassword = TextEditingController();
   var confirmPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Change Password ",
        style: TextStyle(
          color: primary
        ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: TextField(
              cursorColor: primary,
              controller: curPassword,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(

                  border: OutlineInputBorder(
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: primary , width: 0.0),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: primary , width: 2),
                  ),

                  hintText: "Current Password",
                  suffixIcon: IconButton(
                    icon: Icon(_showCurPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    iconSize: 20,
                    color: lightBlack,
                    onPressed: () {
                      setState(() {
                        _showCurPassword=! _showCurPassword;
                      });
                    },
                  )
              ),
              obscureText: !_showCurPassword,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              cursorColor: primary ,
              controller: newPassword,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: primary , width: 0.0),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: primary , width: 2),
                  ),
                  hintText: "New Password",
                  suffixIcon: IconButton(
                    icon: Icon(_showCurPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    iconSize: 20,
                    color: lightBlack,
                    onPressed: () {
                      setState(() {
                        _showPassword=! _showPassword;
                      });
                    },
                  )
              ),
              obscureText: !_showPassword,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              cursorColor: primary,
              controller: confirmPass,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: primary , width: 0.0),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: primary , width: 2),
                  ),
                  hintText: "Confirm Password",
                suffixIcon: IconButton(
                    icon: Icon(_showCurPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    iconSize: 20,
                    color: lightBlack,
                  onPressed: () {
                      setState(() {
                        _showCmPassword=! _showCmPassword;
                      });
                  },
                )
                ),
              obscureText: !_showCmPassword,
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45, 20, 45, 0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primary,
                  maximumSize: Size(100, 40)
                ),
                onPressed: (){
curPass = curPassword.text;
newPass = newPassword.text;
                  changePassWord();
                }, child: Text("Save",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
            )),
          )
          
        ],
      )
    );
  }
  Future<void> changePassWord() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      var parameter = {
        Id: CUR_USERID,
        Name: name ?? "",
        Mobile: mobile ?? "",
        Email: email ?? "",
        Address: address ?? "",
        Storename: storename ?? "",
        Storeurl: storeurl ?? "",
        storeDescription: storeDesc ?? "",
        accountNumber: accNo ?? "",
        accountName: accname ?? "",
        bankCode: bankcode ?? "",
        bankName: bankname ?? "",
        Latitude: latitutute ?? "",
        Longitude: longitude ?? "",
        taxName: taxname ?? "",
        taxNumber: taxnumber ?? "",
        panNumber: pannumber ?? "",
        STATUS: status ?? "1",
        OLDPASS: curPass,
        NEWPASS: newPass,
      };
      apiBaseHelper.postAPICall(updateUserApi, parameter).then(
            (getdata) async {
          bool error = getdata["error"];
          String? msg = getdata["message"];
          if (!error) {
            Navigator.pop(context);
            setSnackbar(msg!);
          } else {
            Navigator.pop(context);
            setSnackbar(msg!);
          }
        },
        onError: (error) {
          setSnackbar(error.toString());
        },
      );
    } else {
      Future.delayed(Duration(seconds: 2)).then(
            (_) async {
          await buttonController!.reverse();
          setState(
                () {
              _isNetworkAvail = false;
            },
          );
        },
      );
    }
  }
  setSnackbar(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: primary,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
