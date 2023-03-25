class User_RC {
  String? name;
  String? email;
  String? fcmToken;
  String? photoURL;
  String? UID;

  User_RC();

  User_RC.set(
      this.name, this.email, this.fcmToken, this.photoURL, this.UID);

  String? getName() {
    return name;
  }

  void setName(String? name) {
    this.name = name;
  }

  String? getEmail() {
    return email;
  }

  void setEmail(String? email) {
    this.email = email;
  }

  String? getFcmToken() {
    return fcmToken;
  }

  void setFcmToken(String? fcmToken) {
    this.fcmToken = fcmToken;
  }

  String? getPhotoURL() {
    return photoURL;
  }

  void setPhotoURL(String? photoURL) {
    this.photoURL = photoURL;
  }

  String? getUID() {
    return UID;
  }

  void setUID(String? UID) {
    this.UID = UID;
  }

  Map<String, Object?> toJson() => {
    'email': email,
    'name': name,
    'photoURL': photoURL,
    'fcmToken': fcmToken,
    'UID': UID,
  };

  factory User_RC.fromJson(Map<String, dynamic> json) => User_RC.set(
    json['name'],
    json['email'],
    json['fcmToken'],
    json['photoURL'],
    json['forumCount'],
  );
}
