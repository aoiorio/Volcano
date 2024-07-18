import 'dart:convert';

import 'package:volcano/domain/entity/user_info.dart';

class UserInfoDTO extends UserInfo{

    UserInfoDTO({
        super.userId,
        super.username,
        super.email,
        super.icon,
        super.doneTodoNum,
        super.notYetTodoNum,
    });

    factory UserInfoDTO.fromJson(Map<String, dynamic> json) => UserInfoDTO(
        userId: json['user_id'],
        username: json['username'],
        email: json['email'],
        icon: json['icon'],
        doneTodoNum: json['done_todo_num'],
        notYetTodoNum: json['not_yet_todo_num'],
    );

    factory UserInfoDTO.fromRawJson(String str) => UserInfoDTO.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    Map<String, dynamic> toJson() => {
        'user_id': userId,
        'username': username,
        'email': email,
        'icon': icon,
        'done_todo_num': doneTodoNum,
        'not_yet_todo_num': notYetTodoNum,
    };
}
