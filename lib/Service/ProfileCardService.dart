import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rozflix/Service/RestartWidget.dart';

import 'package:rozflix/Service/userdata.dart';

import 'auth.dart';

class ProfileCardService extends StatefulWidget {
  final bool isSignIn;
  ProfileCardService(@required this.isSignIn);
  @override
  _ProfileCardServiceState createState() => _ProfileCardServiceState();
}

class _ProfileCardServiceState extends State<ProfileCardService> {
  String genderValue;
  AuthService _authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      genderValue = UserSaveData.getGender();
    });
  }

  onChangeRadio(String val) {
    setState(() {
      genderValue = val;
    });
  }

  onChange(String val, String type) {
    setState(() {
      if (type == "age") {
        if (int.parse(val) >= 18)
          UserSaveData.setAge(userAge: val);
        else
          UserSaveData.setAge(userAge: "?");
      } else if (type == "image")
        UserSaveData.setProfilepic(userProfilepic: val);
      else if (val.length >= 3)
        UserSaveData.setName(username: val);
      else
        UserSaveData.setName(username: "?");
    });
  }

  InkWell _buttonSigIn_Out(bool isSignIn) => InkWell(
      onTap: UserSaveData.getName() != "?" &&
              UserSaveData.getAge() != "?" &&
              UserSaveData.getProfilepic() != "?" &&
              UserSaveData.getGender() != "?"
          ? () async {
              Navigator.of(context).pop();
              if (isSignIn) {
                await _authService.signOut();
              } else {
                RestartWidget.restartApp(context);
                await _authService.signinGoogle();
              }
            }
          : null,
      child: Image.asset(
        isSignIn
            ? "assets/images/logo/google_out.png"
            : "assets/images/logo/google_in.png",
        height: 20,
        color: UserSaveData.getName() != "?" &&
                UserSaveData.getAge() != "?" &&
                UserSaveData.getProfilepic() != "?" &&
                UserSaveData.getGender() != "?"
            ? null
            : Colors.grey,
      ));

  profileImageCard(Function onChange) {
    List<String> maleImage = [
      "assets/images/profile/male/m.png",
      "assets/images/profile/male/m1.png",
      "assets/images/profile/male/m2.png",
      "assets/images/profile/male/m3.png",
      "assets/images/profile/male/m4.png",
      "assets/images/profile/male/m5.png",
      "assets/images/profile/male/m6.png",
      "assets/images/profile/male/m7.png",
      "assets/images/profile/male/m8.png",
    ];
    List<String> femaleImage = [
      "assets/images/profile/female/f.png",
      "assets/images/profile/female/f1.png",
      "assets/images/profile/female/f2.png",
      "assets/images/profile/female/f3.png",
      "assets/images/profile/female/f4.png",
      "assets/images/profile/female/f5.png",
      "assets/images/profile/female/f6.png",
      "assets/images/profile/female/f7.png",
      "assets/images/profile/female/f8.png",
    ];

    return showDialog(
        context: context,
        builder: (builder) => AlertDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            insetPadding: EdgeInsets.symmetric(horizontal: 64),
            title: Text("${UserSaveData.getGender()} Avatar"),
            content: Container(
              height: 150,
              width: double.maxFinite,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: UserSaveData.getGender() != "Male"
                      ? femaleImage.length
                      : maleImage.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 8.0),
                  itemBuilder: (ctx, index) => InkResponse(
                        onTap: () {
                          onChange(
                              UserSaveData.getGender() != "Male"
                                  ? femaleImage[index]
                                  : maleImage[index],
                              "image");

                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            UserSaveData.getGender() != "Male"
                                ? femaleImage[index]
                                : maleImage[index],
                          ),
                        ),
                      )),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final defaultUser = Provider.of<DefaultUser>(context);
    return AlertDialog(
      scrollable: true,
      contentPadding:
          widget.isSignIn ? EdgeInsets.all(8.0) : EdgeInsets.all(16.0),
      actionsPadding: EdgeInsets.all(8.0),
      title: Container(
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Profile",
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline
                    .copyWith(color: Colors.black),
              ),
            ),
            widget.isSignIn
                ? Icon(
                    Icons.verified_user,
                    color: Colors.green,
                  )
                : InkWell(
                    child: Row(
                      children: [
                        Text("Gust",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .caption
                                .copyWith(
                                  color: UserSaveData.getName() != "?" &&
                                          UserSaveData.getAge() != "?" &&
                                          UserSaveData.getProfilepic() != "?" &&
                                          UserSaveData.getGender() != "?"
                                      ? Colors.green
                                      : Colors.grey,
                                )),
                        Icon(
                          Icons.account_circle,
                          color: UserSaveData.getName() != "?" &&
                                  UserSaveData.getAge() != "?" &&
                                  UserSaveData.getProfilepic() != "?" &&
                                  UserSaveData.getGender() != "?"
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ],
                    ),
                    onTap: UserSaveData.getName() != "?" &&
                            UserSaveData.getAge() != "?" &&
                            UserSaveData.getProfilepic() != "?" &&
                            UserSaveData.getGender() != "?"
                        ? () async {
                            await AuthService().signinAnony();
                          }
                        : null),
          ],
        ),
      ),
      content: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 92,
                            width: 92,
                            child: Image.asset(
                              UserSaveData.getProfilepic().length > 10
                                  ? UserSaveData.getProfilepic()
                                  : UserSaveData.getGender() == "Male"
                                      ? "assets/images/profile/male/m.png"
                                      : UserSaveData.getGender() == "Female"
                                          ? "assets/images/profile/female/f.png"
                                          : "assets/images/profile/default.png",
                              height: 72,
                              width: 72,
                            ),
                          ),
                          Positioned(
                              top: -15,
                              right: -12,
                              child: IconButton(
                                splashRadius: 24.0,
                                splashColor: Colors.blue.shade200,
                                disabledColor: Colors.grey,
                                color: Colors.green,
                                icon: Icon(
                                  Icons.repeat,
                                ),
                                onPressed: UserSaveData.getGender() != "?"
                                    ? () => profileImageCard(onChange)
                                    : null,
                              )),
                        ],
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                          child: widget.isSignIn
                              ? Text(
                                  defaultUser.isAnonymous
                                      ? "Username: ${UserSaveData.getName()}\n"
                                          "Age: ${UserSaveData.getAge()}\n"
                                          "Gender: ${UserSaveData.getGender()},\n"
                                          "Gust id: ${defaultUser.uid}\n"
                                      : "Name: ${UserSaveData.getName()}\n"
                                          "Age: ${UserSaveData.getAge()}\n"
                                          "Gender: ${UserSaveData.getGender()}\n"
                                          "User: ${defaultUser.displayName}\n"
                                          "Email id: ${defaultUser.email}\n",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .caption
                                      .copyWith(color: Colors.black),
                                )
                              : Text(
                                  "Username: ${UserSaveData.getName()}\n"
                                  "Age: ${UserSaveData.getAge()}\n"
                                  "Gender: ${UserSaveData.getGender()}\n",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .body1
                                      .copyWith(color: Colors.black),
                                )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          TextFormField(
            onChanged: (val) => onChange(val, "name"),
            autovalidate: true,
            validator: (value) {
              if (value.length < 3 && value.isNotEmpty)
                return "too shot.";
              else
                null;
            },
            keyboardType: TextInputType.name,
            minLines: 1,
            maxLength: 10,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              labelText: UserSaveData.getName() != "?"
                  ? UserSaveData.getName() + "↻"
                  : "Name",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              hintText: 'eg.Rahul',
            ),
          ),
          TextFormField(
            onChanged: (val) => onChange(val, "age"),
            autovalidate: true,
            validator: (value) {
              if (value.length > 0 && value != "") {
                if (int.parse(value) < 18) return "Age restriction";
              } else
                return null;
            },
            maxLength: 2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: UserSaveData.getAge() != "?"
                  ? UserSaveData.getAge() + "↻"
                  : "Age",
              contentPadding: EdgeInsets.all(8),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              hintText: 'eg.More then 18',
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              Text("Gender: "),
              Row(
                children: [
                  Radio(
                    value: "Male",
                    groupValue: genderValue,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      UserSaveData.setGender(gender: "Male");
                      UserSaveData.setProfilepic(
                          userProfilepic: "assets/images/profile/male/m.png");
                      onChangeRadio(val);
                    },
                  ),
                  Text("Male")
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: "Female",
                    groupValue: genderValue,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      UserSaveData.setGender(gender: "Female");
                      UserSaveData.setProfilepic(
                          userProfilepic: "assets/images/profile/female/f.png");
                      onChangeRadio(val);
                    },
                  ),
                  Text("Female")
                ],
              ),
            ],
          )
        ],
      ),
      actions: [
        widget.isSignIn
            ? Container(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonSigIn_Out(widget.isSignIn),
                    InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text("Ok",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .body2
                                .copyWith(
                                  color: Colors.green,
                                )))
                  ],
                ),
              )
            : _buttonSigIn_Out(widget.isSignIn)
      ],
    );
  }
}
