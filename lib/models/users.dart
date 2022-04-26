class Records {
  List<User>? records;

  Records({this.records});

  Records.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <User>[];
      json['records'].forEach((v) {
        records!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? fullname;
  String? username;
  String? idusers;
  String? email;
  String? password;
  String? idcompany;
  String? phoneNumber;
  String? cvFile;

  User(
      {this.fullname,
        this.username,
        this.idusers,
        this.email,
        this.password,
        this.idcompany,
        this.phoneNumber,
        this.cvFile});

  User.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    username = json['username'];
    idusers = json['idusers'];
    email = json['email'];
    password = json['password'];
    idcompany = json['idcompany'];
    phoneNumber = json['phone_number'];
    cvFile = json['cv_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['username'] = username;
    data['idusers'] = idusers;
    data['email'] = email;
    data['password'] = password;
    data['idcompany'] = idcompany;
    data['phone_number'] = phoneNumber;
    data['cv_file'] = cvFile;
    return data;
  }
}