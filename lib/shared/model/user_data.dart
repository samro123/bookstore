class UserData{

  String displayName;
  String avatar;
  String token;

  UserData({required this.displayName, required this.avatar, required this.token});

  factory UserData.fromJson(Map<String, dynamic> map){
    return UserData(
        displayName: map['displayName'],
        avatar: map['avatar'],
        token: map['token']
    );
  }
}