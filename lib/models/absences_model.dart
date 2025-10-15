class AbsencesModel {
  String? message;
  List<Payload>? payload;

  AbsencesModel({this.message, this.payload});

  AbsencesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(new Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  int? admitterId;
  String? admitterNote;
  String? confirmedAt;
  String? createdAt;
  int? crewId;
  String? endDate;
  int? id;
  String? memberNote;
  String? rejectedAt;
  String? startDate;
  String? type;
  int? userId;

  Payload(
      {this.admitterId,
        this.admitterNote,
        this.confirmedAt,
        this.createdAt,
        this.crewId,
        this.endDate,
        this.id,
        this.memberNote,
        this.rejectedAt,
        this.startDate,
        this.type,
        this.userId});

  Payload.fromJson(Map<String, dynamic> json) {
    admitterId = json['admitterId'];
    admitterNote = json['admitterNote'];
    confirmedAt = json['confirmedAt'];
    createdAt = json['createdAt'];
    crewId = json['crewId'];
    endDate = json['endDate'];
    id = json['id'];
    memberNote = json['memberNote'];
    rejectedAt = json['rejectedAt'];
    startDate = json['startDate'];
    type = json['type'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admitterId'] = this.admitterId;
    data['admitterNote'] = this.admitterNote;
    data['confirmedAt'] = this.confirmedAt;
    data['createdAt'] = this.createdAt;
    data['crewId'] = this.crewId;
    data['endDate'] = this.endDate;
    data['id'] = this.id;
    data['memberNote'] = this.memberNote;
    data['rejectedAt'] = this.rejectedAt;
    data['startDate'] = this.startDate;
    data['type'] = this.type;
    data['userId'] = this.userId;
    return data;
  }
}
