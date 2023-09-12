//
//  TrainNoDataModel.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/22.
//

import Foundation

struct TrainNo: Codable {
    let trainDate: String
    let dailyTrainInfo: DailyTrainInfo
    let stopTimes: [StopTime]
}

struct DailyTrainInfo: Codable {
    let trainNo: String
    let direction: Int
    let startingStationID: String
    let startingStationName: Name
    let endingStationID: String
    let endingStationName: Name
    let trainTypeID: String
    let trainTypeCode: String
    let trainTypeName: Name
    let tripLine: Int
}


//[
//  {
//    "TrainDate": "2023-08-22",
//    "DailyTrainInfo": {
//      "TrainNo": "117",
//      "Direction": 1,
//      "StartingStationID": "0900",
//      "StartingStationName": {
//        "Zh_tw": "基隆",
//        "En": "Keelung"
//      },
//      "EndingStationID": "5050",
//      "EndingStationName": {
//        "Zh_tw": "潮州",
//        "En": "Chaozhou"
//      },
//      "TrainTypeID": "110K",
//      "TrainTypeCode": "11",
//      "TrainTypeName": {
//        "Zh_tw": "自強(3000)(EMU3000 型電車)",
//        "En": "Tze-Chiang Ltd. Express(3000)"
//      },
//      "TripLine": 1,
//      "WheelchairFlag": 1,
//      "PackageServiceFlag": 0,
//      "DiningFlag": 0,
//      "BikeFlag": 0,
//      "BreastFeedingFlag": 1,
//      "DailyFlag": 1,
//      "ServiceAddedFlag": 0,
//      "SuspendedFlag": 0,
//      "Note": {
//        "Zh_tw": "每日行駛。本班次第4節至第9節車廂為自由座車廂，非持本班次車票旅客，請勿搭乘。 本列次不發售團體票。"
//      }
//    },
//    "StopTimes": [
//      {
//        "StopSequence": 1,
//        "StationID": "0900",
//        "StationName": {
//          "Zh_tw": "基隆",
//          "En": "Keelung"
//        },
//        "ArrivalTime": "09:35",
//        "DepartureTime": "09:35",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 2,
//        "StationID": "0920",
//        "StationName": {
//          "Zh_tw": "八堵",
//          "En": "Badu"
//        },
//        "ArrivalTime": "09:42",
//        "DepartureTime": "09:43",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 3,
//        "StationID": "0930",
//        "StationName": {
//          "Zh_tw": "七堵",
//          "En": "Qidu"
//        },
//        "ArrivalTime": "09:47",
//        "DepartureTime": "09:49",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 4,
//        "StationID": "0960",
//        "StationName": {
//          "Zh_tw": "汐止",
//          "En": "Xizhi"
//        },
//        "ArrivalTime": "09:57",
//        "DepartureTime": "09:58",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 5,
//        "StationID": "0980",
//        "StationName": {
//          "Zh_tw": "南港",
//          "En": "Nangang"
//        },
//        "ArrivalTime": "10:04",
//        "DepartureTime": "10:05",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 6,
//        "StationID": "0990",
//        "StationName": {
//          "Zh_tw": "松山",
//          "En": "Songshan"
//        },
//        "ArrivalTime": "10:09",
//        "DepartureTime": "10:10",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 7,
//        "StationID": "1000",
//        "StationName": {
//          "Zh_tw": "臺北",
//          "En": "Taipei"
//        },
//        "ArrivalTime": "10:17",
//        "DepartureTime": "10:20",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 8,
//        "StationID": "1020",
//        "StationName": {
//          "Zh_tw": "板橋",
//          "En": "Banqiao"
//        },
//        "ArrivalTime": "10:27",
//        "DepartureTime": "10:29",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 9,
//        "StationID": "1080",
//        "StationName": {
//          "Zh_tw": "桃園",
//          "En": "Taoyuan"
//        },
//        "ArrivalTime": "10:47",
//        "DepartureTime": "10:49",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 10,
//        "StationID": "1100",
//        "StationName": {
//          "Zh_tw": "中壢",
//          "En": "Zhongli_Taoyuan"
//        },
//        "ArrivalTime": "10:57",
//        "DepartureTime": "10:59",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 11,
//        "StationID": "1210",
//        "StationName": {
//          "Zh_tw": "新竹",
//          "En": "Hsinchu"
//        },
//        "ArrivalTime": "11:24",
//        "DepartureTime": "11:26",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 12,
//        "StationID": "1250",
//        "StationName": {
//          "Zh_tw": "竹南",
//          "En": "Zhunan"
//        },
//        "ArrivalTime": "11:40",
//        "DepartureTime": "11:41",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 13,
//        "StationID": "3160",
//        "StationName": {
//          "Zh_tw": "苗栗",
//          "En": "Miaoli"
//        },
//        "ArrivalTime": "11:50",
//        "DepartureTime": "11:52",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 14,
//        "StationID": "3230",
//        "StationName": {
//          "Zh_tw": "豐原",
//          "En": "Fengyuan"
//        },
//        "ArrivalTime": "12:13",
//        "DepartureTime": "12:15",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 15,
//        "StationID": "3300",
//        "StationName": {
//          "Zh_tw": "臺中",
//          "En": "Taichung"
//        },
//        "ArrivalTime": "12:24",
//        "DepartureTime": "12:26",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 16,
//        "StationID": "3360",
//        "StationName": {
//          "Zh_tw": "彰化",
//          "En": "Changhua"
//        },
//        "ArrivalTime": "12:39",
//        "DepartureTime": "12:41",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 17,
//        "StationID": "3390",
//        "StationName": {
//          "Zh_tw": "員林",
//          "En": "Yuanlin"
//        },
//        "ArrivalTime": "12:51",
//        "DepartureTime": "12:53",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 18,
//        "StationID": "3470",
//        "StationName": {
//          "Zh_tw": "斗六",
//          "En": "Douliu"
//        },
//        "ArrivalTime": "13:13",
//        "DepartureTime": "13:14",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 19,
//        "StationID": "4060",
//        "StationName": {
//          "Zh_tw": "民雄",
//          "En": "Minxiong"
//        },
//        "ArrivalTime": "13:27",
//        "DepartureTime": "13:28",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 20,
//        "StationID": "4080",
//        "StationName": {
//          "Zh_tw": "嘉義",
//          "En": "Chiayi"
//        },
//        "ArrivalTime": "13:35",
//        "DepartureTime": "13:37",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 21,
//        "StationID": "4120",
//        "StationName": {
//          "Zh_tw": "新營",
//          "En": "Xinying"
//        },
//        "ArrivalTime": "13:50",
//        "DepartureTime": "13:52",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 22,
//        "StationID": "4220",
//        "StationName": {
//          "Zh_tw": "臺南",
//          "En": "Tainan"
//        },
//        "ArrivalTime": "14:16",
//        "DepartureTime": "14:18",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 23,
//        "StationID": "4310",
//        "StationName": {
//          "Zh_tw": "岡山",
//          "En": "Gangshan"
//        },
//        "ArrivalTime": "14:34",
//        "DepartureTime": "14:36",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 24,
//        "StationID": "4340",
//        "StationName": {
//          "Zh_tw": "新左營",
//          "En": "Xinzuoying"
//        },
//        "ArrivalTime": "14:45",
//        "DepartureTime": "14:47",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 25,
//        "StationID": "4400",
//        "StationName": {
//          "Zh_tw": "高雄",
//          "En": "Kaohsiung"
//        },
//        "ArrivalTime": "14:55",
//        "DepartureTime": "14:57",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 26,
//        "StationID": "4440",
//        "StationName": {
//          "Zh_tw": "鳳山",
//          "En": "Fongshan"
//        },
//        "ArrivalTime": "15:02",
//        "DepartureTime": "15:03",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 27,
//        "StationID": "4460",
//        "StationName": {
//          "Zh_tw": "九曲堂",
//          "En": "Jiuqutang"
//        },
//        "ArrivalTime": "15:09",
//        "DepartureTime": "15:10",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 28,
//        "StationID": "5000",
//        "StationName": {
//          "Zh_tw": "屏東",
//          "En": "Pingtung"
//        },
//        "ArrivalTime": "15:15",
//        "DepartureTime": "15:17",
//        "SuspendedFlag": 0
//      },
//      {
//        "StopSequence": 29,
//        "StationID": "5050",
//        "StationName": {
//          "Zh_tw": "潮州",
//          "En": "Chaozhou"
//        },
//        "ArrivalTime": "15:28",
//        "DepartureTime": "15:31",
//        "SuspendedFlag": 0
//      }
//    ],
//    "UpdateTime": "2023-08-22T05:58:39+08:00",
//    "VersionID": 15
//  }
//]
