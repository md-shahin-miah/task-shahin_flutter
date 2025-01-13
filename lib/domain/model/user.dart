
import 'meta_data.dart';

class User {
  User({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.isPrivateChat,
    required this.expireDate,
    required this.status,
    required this.pauseDate,
    required this.userType,
    required this.meta,
  });

  final int? id;
  final String? fullName;
  final String? profilePic;
  final num? isPrivateChat;
  final dynamic expireDate;
  final dynamic status;
  final dynamic pauseDate;
  final String? userType;
  final MetaDataClass? meta;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      fullName: json["full_name"],
      profilePic: json["profile_pic"],
      isPrivateChat: json["is_private_chat"],
      expireDate: json["expire_date"],
      status: json["status"],
      pauseDate: json["pause_date"],
      userType: json["user_type"],
      meta: json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "profile_pic": profilePic,
    "is_private_chat": isPrivateChat,
    "expire_date": expireDate,
    "status": status,
    "pause_date": pauseDate,
    "user_type": userType,
    "meta": meta?.toJson(),
  };

  @override
  String toString(){
    return "$id, $fullName, $profilePic, $isPrivateChat, $expireDate, $status, $pauseDate, $userType, $meta, ";
  }
}