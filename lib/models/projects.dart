class ProjectRecords {
  List<Projects>? records;
  ProjectRecords({this.records});

  ProjectRecords.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Projects>[];
      json['records'].forEach((v) {
        records!.add(Projects.fromJson(v));
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

class Projects {
  String? idprojects;
  String? projectName;
  String? projectDescription;
  String? maxNbUsers;
  String? price;
  String? idspecialization;
  String? idusers;
  String? idcompanies;
  String? specializationName;
  String? companyName;
  String? companyLogo;
  String? userFullName;
  String? projectDate;
  String? projectTypeWork;

  Projects(
      {this.idprojects,
        this.projectName,
        this.projectDescription,
        this.maxNbUsers,
        this.price,
        this.idspecialization,
        this.idusers,
        this.idcompanies,
        this.specializationName,
        this.companyName,
        this.companyLogo,
        this.userFullName,
        this.projectDate,
        this.projectTypeWork});

  Projects.fromJson(Map<String, dynamic> json) {
    idprojects = json['idprojects'];
    projectName = json['project_name'];
    projectDescription = json['project_description'];
    maxNbUsers = json['max_nb_users'];
    price = json['price'];
    idspecialization = json['idspecialization'];
    idusers = json['idusers'];
    idcompanies = json['idcompanies'];
    specializationName = json['specialization_name'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    userFullName = json['user_full_name'];
    projectDate = json['project_date'];
    projectTypeWork = json['project_type_work'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idprojects'] = idprojects;
    data['project_name'] = projectName;
    data['project_description'] = projectDescription;
    data['max_nb_users'] = maxNbUsers;
    data['price'] = price;
    data['idspecialization'] = idspecialization;
    data['idusers'] = idusers;
    data['idcompanies'] = idcompanies;
    data['specialization_name'] = specializationName;
    data['company_name'] = companyName;
    data['company_logo'] = companyLogo;
    data['user_full_name'] = userFullName;
    data['project_date'] = projectDate;
    data['project_type_work'] = projectTypeWork;
    return data;
  }
}