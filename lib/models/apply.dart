class ApplyRecords {
  List<ProjectApplies>? records;

  ApplyRecords({this.records});

  ApplyRecords.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <ProjectApplies>[];
      json['records'].forEach((v) {
        records!.add(ProjectApplies.fromJson(v));
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

class ProjectApplies {
  String? idprojectsApplies;
  String? idprojects;
  String? idusers;
  String? idstatus;
  String? userRate;
  String? projectName;
  String? userName;
  String? statusName;
  String? specializationName;

  ProjectApplies(
      {this.idprojectsApplies,
        this.idprojects,
        this.idusers,
        this.idstatus,
        this.userRate,
        this.projectName,
        this.userName,
        this.statusName,
        this.specializationName});

  ProjectApplies.fromJson(Map<String, dynamic> json) {
    idprojectsApplies = json['idprojects_applies'];
    idprojects = json['idprojects'];
    idusers = json['idusers'];
    idstatus = json['idstatus'];
    userRate = json['user_rate'];
    projectName = json['project_name'];
    userName = json['user_name'];
    statusName = json['status_name'];
    specializationName = json['specialization_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idprojects_applies'] = idprojectsApplies;
    data['idprojects'] = idprojects;
    data['idusers'] = idusers;
    data['idstatus'] = idstatus;
    data['user_rate'] = userRate;
    data['project_name'] = projectName;
    data['user_name'] = userName;
    data['status_name'] = statusName;
    data['specialization_name'] = specializationName;
    return data;
  }
}