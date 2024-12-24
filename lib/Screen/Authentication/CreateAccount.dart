import 'dart:convert';
import 'dart:io';

import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../Helper/Color.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  var size, height, width;
  String gender = "Male";
  String dropdownValue = 'Select';
  // String dropdownValue2 = '----Select Pincode----';
  List<String> categories = ['Select', 'Mart', 'Food'];
  List<String> pincodeList = [
    '----Select Pincode----',
    '452001',
    '452010',
    '560067'
  ];

  bool isLoading = false;
  TextEditingController dobController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeUrlController = TextEditingController();
  TextEditingController storeDescriptionController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController taxNameController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankCodeController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController addressProofController = TextEditingController();
  TextEditingController storeLogoController = TextEditingController();

  TextEditingController gstFileController = TextEditingController();
  TextEditingController foodLicController = TextEditingController();
  TextEditingController bankPassController = TextEditingController();
  TextEditingController profileController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 78.0),
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                SizedBox(
                  height: 59,
                  child: DropdownButtonFormField<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Name",
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  keyboardType: TextInputType.number,
                  prefix: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      "+91",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  hint: "Enter Mobile Number",
                  controller: mobileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  keyboardType: TextInputType.emailAddress,
                  hint: "Enter Email",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                PasswordFild(
                  hint: "Password",
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                PasswordFild(
                  hint: "Enter Confirm Password",
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Address",
                  controller: addressController,
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Enter City",
                  controller: cityController,
                ),
                // SizedBox(height: 15),
                // TextButtonWidget(
                //     hint: "Enter Pincode",
                //     controller: pinCodeController,
                //     keyboardType: TextInputType.number),
                SizedBox(height: 15),
                // SizedBox(
                //   height: 57,
                //   // child: DropdownButtonFormField<String>(
                //   //   value: dropdownValue2,
                //   //   onChanged: (String? newValue) {
                //   //     setState(() {
                //   //       dropdownValue2 = newValue!;
                //   //     });
                //   //   },
                //   //   items: pincodeList
                //   //       .map<DropdownMenuItem<String>>((String value) {
                //   //     return DropdownMenuItem<String>(
                //   //       value: value,
                //   //       child: Text(value),
                //   //     );
                //   //   }).toList(),
                //   //   decoration: InputDecoration(
                //   //     filled: true,
                //   //     fillColor: Colors.white,
                //   //     border: OutlineInputBorder(
                //   //       borderRadius: BorderRadius.circular(8),
                //   //       borderSide: BorderSide(color: Colors.grey),
                //   //     ),
                //   //     enabledBorder: OutlineInputBorder(
                //   //       borderRadius: BorderRadius.circular(8),
                //   //       borderSide: BorderSide(color: Colors.grey),
                //   //     ),
                //   //     focusedBorder: OutlineInputBorder(
                //   //       borderRadius: BorderRadius.circular(8),
                //   //       borderSide: BorderSide(color: Colors.grey),
                //   //     ),
                //   //   ),
                //   // ),
                // ),
                // SizedBox(height: 15),
                TextFilePickWidget(
                    hint: "Address Proof",
                    imagePathController: addressProofController),
                SizedBox(height: 15),
                TextFilePickWidget(
                    hint: "Gst File", imagePathController: gstFileController),
                SizedBox(height: 15),
                TextFilePickWidget(
                    hint: "Food License",
                    imagePathController: foodLicController),
                SizedBox(height: 15),
                TextFilePickWidget(
                    hint: "Bank Passbook",
                    imagePathController: bankPassController),
                SizedBox(height: 15),
                TextFilePickWidget(
                    hint: "Profile Picture",
                    imagePathController: profileController),
                SizedBox(height: 15),
                TextButtonWidget(
                    hint: "DOB",
                    suffix: Icon(Icons.calendar_month),
                    controller: dobController,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: primary,
                              accentColor: primary,
                              colorScheme: ColorScheme.light(
                                  primary: primary), // Selected date color
                              buttonTheme: ButtonThemeData(
                                textTheme:
                                    ButtonTextTheme.primary, // Buttons color
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dobController.text =
                              "${pickedDate.toLocal()}".split(' ')[0];
                        });
                      }
                    }),
                SizedBox(height: 15),
                Text("Gender",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    Radio<String>(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text("Male"),
                    Radio<String>(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text("Female"),
                    Radio<String>(
                      value: "Other",
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text("Other"),
                  ],
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Tax Name",
                  controller: taxNameController,
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Tax Number",
                  controller: taxNumberController,
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                    hint: "Pan Number", controller: panNumberController),
                SizedBox(height: 15),
                SizedBox(height: 15),
                Text("Store Details",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Store Name",
                  controller: storeNameController,
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Store URL",
                  controller: storeUrlController,
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: " Store Description",
                  controller: storeDescriptionController,
                ),
                SizedBox(height: 15),
                TextFilePickWidget(
                  hint: "Logo",
                  imagePathController: storeLogoController,
                ),
                SizedBox(height: 15),
                Text("Bank Details",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Account Number",
                  controller: accountNumberController,
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Account Holder Name",
                  controller: accountNameController,
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "IFSC Code",
                  controller: bankCodeController,
                ),
                SizedBox(height: 15),
                TextButtonWidget(
                  hint: "Bank Name",
                  controller: bankNameController,
                ),
                SizedBox(height: 15),
                loginBtn(),
                SizedBox(height: 30),
                //showPlacePicker(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginBtn() {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState!.validate() && isLoading == false) {
          registerUser();
        }
      },
      child: Container(
        height: height / 20,
        width: width / 1,
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
      ),
    );
  }

  registerUser() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=df5385d665217dba30014022ebc9598ab69bb28d'
    };
    var request = http.MultipartRequest('POST', registerUserApi);
    request.fields.addAll({
      'master_category': dropdownValue == 'Mart' ? '1' : "2",
      "mobile": mobileController.text,
      "email": emailController.text,
      "name": nameController.text,
      "password": passwordController.text,
      "confirm_password": confirmPasswordController.text,
      "address": addressController.text,
      "city": cityController.text,
      // "pincode": dropdownValue2 ?? "",
      "dob": dobController.text,
      "gender": gender,
      "store_name": storeNameController.text,
      "store_url": storeUrlController.text,
      "store_description": storeDescriptionController.text,
      "pan_number": panNumberController.text,
      "tax_name": taxNameController.text,
      "tax_number": taxNumberController.text,
      "bank_name": bankNameController.text,
      "bank_code": bankCodeController.text,
      "account_name": accountNameController.text,
      "account_number": accountNumberController.text,
      "latitude": "7.6445",
      "longitude": "7.7674"
    });
    print('Anjaliparameter____________: ${request.fields}');

    if (addressProofController.text != '') {
      request.files.add(await http.MultipartFile.fromPath(
          'address_proof', addressProofController.text));
    }
    if (storeLogoController.text != '') {
      request.files.add(await http.MultipartFile.fromPath(
          'store_logo', storeLogoController.text));
    }
    if (gstFileController.text != '') {
      request.files.add(await http.MultipartFile.fromPath(
          'gst_file', gstFileController.text));
    }
    if (foodLicController.text != '') {
      request.files.add(await http.MultipartFile.fromPath(
          'food_lic', foodLicController.text));
    }
    if (bankPassController.text != '') {
      request.files.add(await http.MultipartFile.fromPath(
          'bank_pass', bankPassController.text));
    }
    if (profileController.text != '') {
      request.files.add(
          await http.MultipartFile.fromPath('pro_pic', profileController.text));
    }

//     address_proof:
// store_logo:
// gst_file:
// food_lic:
// bank_pass:
// pro_pic:
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      bool error = finalResult['error'];
      String msg = finalResult['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg);
      } else {
        Fluttertoast.showToast(msg: msg);
        Navigator.pop(context);
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }

    setState(() {
      isLoading = false;
    });
  }

// Future<void> registerUser() async {
//   var param = {
//     'master_category': "1",
//     "mobile": mobileController.text,
//     "email": emailController.text,
//     "name": nameController.text,
//     "password": passwordController.text,
//     "confirm_password": confirmPasswordController.text,
//     "address": addressController.text,
//     "city": cityController.text,
//     "pincode": pinCodeController.text,
//     "dob": dobController.text,
//     "gender": gender,
//     "store_name": storeNameController.text,
//     "store_url": storeUrlController.text,
//     "pan_number": panNumberController.text,
//     "tax_name": taxNameController.text,
//     "tax_number": taxNumberController.text,
//     "bank_name": bankNameController.text,
//     "bank_code": bankCodeController.text,
//     "account_name": accountNameController.text,
//     "account_number": accountNumberController.text,
//     "latitude": "7.6445",
//     "longitude": "7.7674"
//   };
//   apiBaseHelper.postAPICall(registerUserApi, param).then((getData) {
//     bool error = getData['error'];
//     String msg = getData['message'];
//     print('____param______${registerUserApi}______${param}___');
//     if (error) {
//       Fluttertoast.showToast(msg: msg);
//     } else {
//       Fluttertoast.showToast(msg: msg);
//     }
//   });
// }
}

class TextButtonWidget extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputType? keyboardType;

  TextButtonWidget({
    required this.hint,
    this.controller,
    this.onTap,
    this.validator,
    this.suffix,
    this.prefix,
    this.keyboardType,
  });

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: TextFormField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          onTap: widget.onTap,
          readOnly: widget.onTap != null,
          validator: widget.validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            hintText: widget.hint,
            suffixIcon: widget.suffix,
            prefixIcon: widget.prefix,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFilePickWidget extends StatefulWidget {
  final String hint;
  TextEditingController imagePathController;
  TextFilePickWidget({required this.hint, required this.imagePathController});

  @override
  State<TextFilePickWidget> createState() => _TextFilePickWidgetState();
}

class _TextFilePickWidgetState extends State<TextFilePickWidget> {
  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        widget.imagePathController.text = result.files.single.path ?? '';
      });
    }
  }

  Future getImage(BuildContext context, ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      enableCloseButton: true,
      closeIcon: Icon(
        Icons.close,
        color: Colors.red,
        size: 12,
      ),
      context: context,
      source: source,
      barrierDismissible: true,
      cameraIcon: Icon(
        Icons.camera_alt,
        color: Colors.red,
      ),
      cameraText: Text(
        "From Camera",
        style: TextStyle(color: Colors.red),
      ),
      galleryText: Text(
        "From Gallery",
        style: TextStyle(color: Colors.blue),
      ),
    );

    if (image != null) {
      setState(() {
        widget.imagePathController.text = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Container(
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.width / 1.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10),
            widget.imagePathController.text != ''
                ? Image.file(
                    File(widget.imagePathController.text),
                    height: 70.0,
                    width: 70.0,
                  )
                : Text(
                    widget.hint,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
            Spacer(),
            GestureDetector(
              onTap: () => getImage(context, ImgSource.Both),
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Choose File",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordFild extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  PasswordFild({required this.hint, this.controller, this.validator});

  @override
  State<PasswordFild> createState() => _PasswordFildState();
}

class _PasswordFildState extends State<PasswordFild> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          validator: widget.validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            hintText: widget.hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ImagePickerGC {
  static Future pickImage({
    required BuildContext context,
    required ImgSource source,
    bool? enableCloseButton,
    double? maxWidth,
    double? maxHeight,
    Icon? cameraIcon,
    Icon? galleryIcon,
    Widget? cameraText,
    Widget? galleryText,
    bool barrierDismissible = false,
    Icon? closeIcon,
    int? imageQuality,
  }) async {
    assert(imageQuality == null || (imageQuality >= 0 && imageQuality <= 100));

    if (maxWidth != null && maxWidth < 0) {
      throw ArgumentError.value(maxWidth, 'maxWidth cannot be negative');
    }

    if (maxHeight != null && maxHeight < 0) {
      throw ArgumentError.value(maxHeight, 'maxHeight cannot be negative');
    }

    switch (source) {
      case ImgSource.Camera:
        return await ImagePicker().getImage(
          source: ImageSource.camera,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        );
      case ImgSource.Gallery:
        return await ImagePicker().getImage(
          source: ImageSource.gallery,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        );
      case ImgSource.Both:
        return await showDialog<void>(
          context: context,
          barrierDismissible: barrierDismissible,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (enableCloseButton == true)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: closeIcon ?? Icon(Icons.close, size: 14),
                      ),
                    ),
                  InkWell(
                    onTap: () async {
                      ImagePicker()
                          .getImage(
                        source: ImageSource.gallery,
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                        imageQuality: imageQuality,
                      )
                          .then((image) {
                        Navigator.pop(context, image);
                      });
                    },
                    child: Container(
                      child: ListTile(
                        title: galleryText ?? Text("Gallery"),
                        leading: galleryIcon ??
                            Icon(Icons.image, color: Colors.deepPurple),
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 1,
                    color: Colors.black12,
                  ),
                  InkWell(
                    onTap: () async {
                      ImagePicker()
                          .getImage(
                        source: ImageSource.camera,
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                      )
                          .then((image) {
                        Navigator.pop(context, image);
                      });
                    },
                    child: Container(
                      child: ListTile(
                        title: cameraText ?? Text("Camera"),
                        leading: cameraIcon ??
                            Icon(Icons.camera, color: Colors.deepPurple),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
    }
  }
}

enum ImgSource { Camera, Gallery, Both }
