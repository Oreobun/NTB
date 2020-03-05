class Response {
  List<Items> items;

  Response({this.items});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String timestamp;
  List<CarparkData> carparkData;

  Items({this.timestamp, this.carparkData});

  Items.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    if (json['carpark_data'] != null) {
      carparkData = new List<CarparkData>();
      json['carpark_data'].forEach((v) {
        carparkData.add(new CarparkData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    if (this.carparkData != null) {
      data['carpark_data'] = this.carparkData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarparkData {
  List<CarparkInfo> carparkInfo;
  String carparkNumber;
  String updateDatetime;

  CarparkData({this.carparkInfo, this.carparkNumber, this.updateDatetime});

  CarparkData.fromJson(Map<String, dynamic> json) {
    if (json['carpark_info'] != null) {
      carparkInfo = new List<CarparkInfo>();
      json['carpark_info'].forEach((v) {
        carparkInfo.add(new CarparkInfo.fromJson(v));
      });
    }
    carparkNumber = json['carpark_number'];
    updateDatetime = json['update_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carparkInfo != null) {
      data['carpark_info'] = this.carparkInfo.map((v) => v.toJson()).toList();
    }
    data['carpark_number'] = this.carparkNumber;
    data['update_datetime'] = this.updateDatetime;
    return data;
  }
}

class CarparkInfo {
  String totalLots;
  String lotType;
  String lotsAvailable;

  CarparkInfo({this.totalLots, this.lotType, this.lotsAvailable});

  CarparkInfo.fromJson(Map<String, dynamic> json) {
    totalLots = json['total_lots'];
    lotType = json['lot_type'];
    lotsAvailable = json['lots_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_lots'] = this.totalLots;
    data['lot_type'] = this.lotType;
    data['lots_available'] = this.lotsAvailable;
    return data;
  }
}