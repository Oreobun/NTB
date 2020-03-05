class Carpark {
  String ts;
//  final List<CarparkData> cpd;

//  Carpark({this.ts, this.cpd});

//  factory Carpark.fromJson(List<dynamic> parsedJson) {
////
////    List<CarparkData> cpl = new List<CarparkData>();
////    cpl = parsedJson.map((i)=>CarparkData.fromJson(i)).toList();
//
//    return new Carpark(
//        ts: parsedJson[0],
////        cpd: cpl
//    );
//  }
  Carpark({this.ts});
  Carpark.fromJson(Map<String, dynamic> jsonMap) {
    this.ts = (jsonMap['items']);

  }
}

//
//class CarparkData{
//  final List<CarparkInfo> carparkInfo;
//  final String carparkNo;
//  final String updateDateTime;
//
//
//  CarparkData({
//    this.carparkInfo,
//    this.carparkNo,
//    this.updateDateTime
//  });
//
//  factory CarparkData.fromJson(List<dynamic> parsedJson) {
//
//    List<CarparkInfo> carparkList = new List<CarparkInfo>();
//    carparkList = parsedJson.map((i)=>CarparkInfo.fromJson(i)).toList();
//
//    return new CarparkData(
//        carparkInfo: carparkList,
//        carparkNo: parsedJson[2],
//        updateDateTime: parsedJson[3]
//    );
//  }
//}
//
//
//
//class CarparkInfo{
//  final String totalLots;
//  final String lotType;
//  final String lotsAvailable;
//
//  CarparkInfo({this.totalLots, this.lotType, this.lotsAvailable});
//
//  factory CarparkInfo.fromJson(Map<String, dynamic> parsedJson){
//    return CarparkInfo(
//        totalLots:parsedJson['total_lots'],
//        lotType:parsedJson['lot_type'],
//        lotsAvailable:parsedJson['lots_available']
//    );
//  }
//}
