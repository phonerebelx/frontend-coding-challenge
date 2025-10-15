class MembersModel {
  String? message;
  List<MemberPayload>? payload;

  MembersModel({this.message, this.payload});

  MembersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <MemberPayload>[];
      json['payload'].forEach((v) {
        payload!.add(MemberPayload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberPayload {
  int? crewId;
  int? id;
  String? image;
  String? name;
  int? userId;

  MemberPayload({this.crewId, this.id, this.image, this.name, this.userId});

  MemberPayload.fromJson(Map<String, dynamic> json) {
    crewId = json['crewId'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['crewId'] = crewId;
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['userId'] = userId;
    return data;
  }
}
