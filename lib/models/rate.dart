class RateRecord {
  List<Records>? records;

  RateRecord({this.records});

  RateRecord.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  String? idusers;
  String? username;
  String? fullname;
  String? email;
  String? nbUsersRate;
  String? totalRate;

  Records(
      {this.idusers,
        this.username,
        this.fullname,
        this.email,
        this.nbUsersRate,
        this.totalRate});

  Records.fromJson(Map<String, dynamic> json) {
    idusers = json['idusers'];
    username = json['username'];
    fullname = json['fullname'];
    email = json['email'];
    nbUsersRate = json['nb_users_rate'];
    totalRate = json['total_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idusers'] = this.idusers;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['nb_users_rate'] = this.nbUsersRate;
    data['total_rate'] = this.totalRate;
    return data;
  }
}