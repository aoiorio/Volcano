import 'dart:convert';

// NOTE this file is for sending this model as a Body to back-end
// NOTE the values that return will be dtos (entities)
class SignInVolcanoUserModel {
    final String? email;
    final String? password;

    SignInVolcanoUserModel({
        this.email,
        this.password,
    });

    factory SignInVolcanoUserModel.fromRawJson(String str) => SignInVolcanoUserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SignInVolcanoUserModel.fromJson(Map<String, dynamic> json) => SignInVolcanoUserModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
