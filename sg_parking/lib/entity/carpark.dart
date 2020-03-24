/*
This object class contains attributes of a carpark
 */

class Response {
  List<CarparkInfo> items;

  Response({this.items});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<CarparkInfo>();
      json['items'].forEach((v) {
        items.add(new CarparkInfo.fromJson(v));
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

class CarparkInfo {
  String carParkNo;
  int totalLots;
  int availableLots;
  String updatedAt;
  String address;
  double xCoord;
  double yCoord;
  double lat;
  double lng;
  String carParkType;
  String typeOfParkingSystem;
  String shortTermParking;
  String freeParking;
  String nightParking;
  int carParkDecks;
  int gantryHeight;
  String carParkBasement;
  int iId;

  CarparkInfo(
      {this.carParkNo,
        this.totalLots,
        this.availableLots,
        this.updatedAt,
        this.address,
        this.xCoord,
        this.yCoord,
        this.lat,
        this.lng,
        this.carParkType,
        this.typeOfParkingSystem,
        this.shortTermParking,
        this.freeParking,
        this.nightParking,
        this.carParkDecks,
        this.gantryHeight,
        this.carParkBasement,
        this.iId});

  CarparkInfo.fromJson(Map<String, dynamic> json) {
    carParkNo = json['car_park_no'];
    totalLots = json['total_lots'];
    availableLots = json['available_lots'];
    updatedAt = json['updated_at'];
    address = json['address'];
    xCoord = json['x_coord'] + .0;
    yCoord = json['y_coord'] + .0;
    lat = json['lat'];
    lng = json['lng'];
    carParkType = json['car_park_type'];
    typeOfParkingSystem = json['type_of_parking_system'];
    shortTermParking = json['short_term_parking'];
    freeParking = json['free_parking'];
    nightParking = json['night_parking'];
    carParkDecks = json['car_park_decks'];
    gantryHeight = json['gantry_height'];
    carParkBasement = json['car_park_basement'];
    iId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_park_no'] = this.carParkNo;
    data['total_lots'] = this.totalLots;
    data['available_lots'] = this.availableLots;
    data['updated_at'] = this.updatedAt;
    data['address'] = this.address;
    data['x_coord'] = this.xCoord;
    data['y_coord'] = this.yCoord;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['car_park_type'] = this.carParkType;
    data['type_of_parking_system'] = this.typeOfParkingSystem;
    data['short_term_parking'] = this.shortTermParking;
    data['free_parking'] = this.freeParking;
    data['night_parking'] = this.nightParking;
    data['car_park_decks'] = this.carParkDecks;
    data['gantry_height'] = this.gantryHeight;
    data['car_park_basement'] = this.carParkBasement;
    data['_id'] = this.iId;
    return data;
  }
}

