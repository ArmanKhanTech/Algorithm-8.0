class TeamModel {
  String? teamName;

  String? nameLead;
  String? emailLead;
  String? contactLead;
  String? githubLead;
  String? linkedinLead;
  String? collegeLead;
  String? resumeLead;
  String? imageLead;

  String? nameMember2;
  String? emailMember2;
  String? contactMember2;
  String? githubMember2;
  String? linkedinMember2;
  String? collegeMember2;
  String? resumeMember2;
  String? imageMember2;

  String? nameMember3;
  String? emailMember3;
  String? contactMember3;
  String? githubMember3;
  String? linkedinMember3;
  String? collegeMember3;
  String? resumeMember3;
  String? imageMember3;

  String? status;

  TeamModel({
    this.teamName,
    this.nameLead,
    this.emailLead,
    this.contactLead,
    this.githubLead,
    this.linkedinLead,
    this.collegeLead,
    this.resumeLead,
    this.imageLead,
    this.nameMember2,
    this.emailMember2,
    this.contactMember2,
    this.githubMember2,
    this.linkedinMember2,
    this.collegeMember2,
    this.resumeMember2,
    this.imageMember2,
    this.nameMember3,
    this.emailMember3,
    this.contactMember3,
    this.githubMember3,
    this.linkedinMember3,
    this.collegeMember3,
    this.resumeMember3,
    this.imageMember3,
    this.status,
  });

  TeamModel.fromJson(Map<String, dynamic> json) {
    teamName = json['teamName'];
    nameLead = json['nameLead'];
    emailLead = json['emailLead'];
    contactLead = json['contactLead'];
    githubLead = json['githubLead'];
    linkedinLead = json['linkedinLead'];
    collegeLead = json['collegeLead'];
    resumeLead = json['resumeLead'];
    imageLead = json['imageLead'];
    nameMember2 = json['nameMember2'];
    emailMember2 = json['emailMember2'];
    contactMember2 = json['contactMember2'];
    githubMember2 = json['githubMember2'];
    linkedinMember2 = json['linkedinMember2'];
    collegeMember2 = json['collegeMember2'];
    resumeMember2 = json['resumeMember2'];
    imageMember2 = json['imageMember2'];
    nameMember3 = json['nameMember3'];
    emailMember3 = json['emailMember3'];
    contactMember3 = json['contactMember3'];
    githubMember3 = json['githubMember3'];
    linkedinMember3 = json['linkedinMember3'];
    collegeMember3 = json['collegeMember3'];
    resumeMember3 = json['resumeMember3'];
    imageMember3 = json['imageMember3'];
    status = json['status'];
  }
}
