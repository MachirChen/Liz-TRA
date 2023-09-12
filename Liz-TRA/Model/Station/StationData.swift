//
//  StationData.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/9.
//

import Foundation

struct CityData {
    static let cities = [keelung, newTaipei, taipei, taoyuan, hsinchu, miaoli, taichung, changhua, nantou, yunlin, chiayi, tainan, kaohsiung, pingtung, taitung, hualien, yilan, chengzhuiLine, pingxiLine, shenaoLine, liujiaLine, neiwanLine, jijiLine, shalunLine]
    
    static let subLine = [chengzhuiLine, pingxiLine, shenaoLine, liujiaLine, neiwanLine, jijiLine, shalunLine]
}

struct City {
    let name: String
    let stations: [TrainStation]
}

struct TrainStation {
    let name: String
    let id: String
}

let cities = [keelung, newTaipei, taipei, taoyuan, hsinchu, miaoli, taichung, changhua, nantou, yunlin, chiayi, tainan, kaohsiung, pingtung, taitung, hualien, yilan, chengzhuiLine, pingxiLine, shenaoLine, liujiaLine, neiwanLine, jijiLine, shalunLine]

let keelung = City(name: "基隆", stations: keelungCityTrainStations)
let newTaipei = City(name: "新北", stations: newTaipeiCityTrainStations)
let taipei = City(name: "臺北", stations: taipeiCityTrainStations)
let taoyuan = City(name: "桃園", stations: taoyuanCityTrainStations)
let hsinchu = City(name: "新竹", stations: hsinchuTrainStations)
let miaoli = City(name: "苗栗", stations: miaoliCountyTrainStations)
let taichung = City(name: "臺中", stations: taichungCityTrainStations)
let changhua = City(name: "彰化", stations: changhuaCountyTrainStations)
let nantou = City(name: "南投", stations: nantouCountyTrainStations)
let yunlin = City(name: "雲林", stations: yunlinCountyTrainStations)
let chiayi = City(name: "嘉義", stations: chiayiTrainStations)
let tainan = City(name: "臺南", stations: tainanCityTrainStations)
let kaohsiung = City(name: "高雄", stations: kaohsiungCityTrainStations)
let pingtung = City(name: "屏東", stations: pingtungCountyTrainStations)
let taitung = City(name: "臺東", stations: taitungCountyTrainStations)
let hualien = City(name: "花蓮", stations: hualienCountyTrainStations)
let yilan = City(name: "宜蘭", stations: yilanCountyTrainStations)
let chengzhuiLine = City(name: "成追線", stations: chengzhuiLineTrainStations)
let pingxiLine = City(name: "平溪線", stations: pingxiLineTrainStations)
let shenaoLine = City(name: "深澳線", stations: shenaoLineTrainStations)
let liujiaLine = City(name: "六家線", stations: liujiaLineTrainStations)
let neiwanLine = City(name: "內灣線", stations: neiwanLineTrainStations)
let jijiLine = City(name: "集集線", stations: jijiLineTrainStations)
let shalunLine = City(name: "沙崙線", stations: shalunLineTrainStations)


let keelungCityTrainStations: [TrainStation] = [
    TrainStation(name: "基隆", id: "0900"),
    TrainStation(name: "三坑", id: "0910"),
    TrainStation(name: "八堵", id: "0920"),
    TrainStation(name: "七堵", id: "0930"),
    TrainStation(name: "百福", id: "0940"),
    TrainStation(name: "海科館", id: "7361"),
    TrainStation(name: "暖暖", id: "7390")
]

let newTaipeiCityTrainStations: [TrainStation] = [
    TrainStation(name: "五堵", id: "0950"),
    TrainStation(name: "汐止", id: "0960"),
    TrainStation(name: "汐科", id: "0970"),
    TrainStation(name: "板橋", id: "1020"),
    TrainStation(name: "浮洲", id: "1030"),
    TrainStation(name: "樹林", id: "1040"),
    TrainStation(name: "南樹林", id: "1050"),
    TrainStation(name: "山佳", id: "1060"),
    TrainStation(name: "鶯歌", id: "1070"),
    TrainStation(name: "福隆", id: "7290"),
    TrainStation(name: "貢寮", id: "7300"),
    TrainStation(name: "雙溪", id: "7310"),
    TrainStation(name: "牡丹", id: "7320"),
    TrainStation(name: "三貂嶺", id: "7330"),
    TrainStation(name: "大華", id: "7331"),
    TrainStation(name: "十分", id: "7332"),
    TrainStation(name: "望古", id: "7333"),
    TrainStation(name: "嶺腳", id: "7334"),
    TrainStation(name: "平溪", id: "7335"),
    TrainStation(name: "菁桐", id: "7336"),
    TrainStation(name: "猴硐", id: "7350"),
    TrainStation(name: "瑞芳", id: "7360"),
    TrainStation(name: "八斗子", id: "7362"),
    TrainStation(name: "四腳亭", id: "7380")
]

let taipeiCityTrainStations: [TrainStation] = [
    TrainStation(name: "南港", id: "0980"),
    TrainStation(name: "松山", id: "0990"),
    TrainStation(name: "臺北", id: "1000"),
    TrainStation(name: "臺北-環島", id: "1001"),
    TrainStation(name: "萬華", id: "1010")
]

let taoyuanCityTrainStations: [TrainStation] = [
    TrainStation(name: "桃園", id: "1080"),
    TrainStation(name: "內壢", id: "1090"),
    TrainStation(name: "中壢", id: "1100"),
    TrainStation(name: "埔心", id: "1110"),
    TrainStation(name: "楊梅", id: "1120"),
    TrainStation(name: "富岡", id: "1130"),
    TrainStation(name: "新富", id: "1140")
]

let hsinchuTrainStations: [TrainStation] = [
    TrainStation(name: "北湖", id: "1150"),
    TrainStation(name: "湖口", id: "1160"),
    TrainStation(name: "新豐", id: "1170"),
    TrainStation(name: "竹北", id: "1180"),
    TrainStation(name: "竹中", id: "1193"),
    TrainStation(name: "六家", id: "1194"),
    TrainStation(name: "上員", id: "1201"),
    TrainStation(name: "榮華", id: "1202"),
    TrainStation(name: "竹東", id: "1203"),
    TrainStation(name: "橫山", id: "1204"),
    TrainStation(name: "九讚頭", id: "1205"),
    TrainStation(name: "合興", id: "1206"),
    TrainStation(name: "富貴", id: "1207"),
    TrainStation(name: "內灣", id: "1208"),
    TrainStation(name: "北新竹", id: "1190"),
    TrainStation(name: "千甲", id: "1191"),
    TrainStation(name: "新莊", id: "1192"),
    TrainStation(name: "新竹", id: "1210"),
    TrainStation(name: "三姓橋", id: "1220"),
    TrainStation(name: "香山", id: "1230")
]

let miaoliCountyTrainStations: [TrainStation] = [
    TrainStation(name: "崎頂", id: "1240"),
    TrainStation(name: "竹南", id: "1250"),
    TrainStation(name: "談文", id: "2110"),
    TrainStation(name: "大山", id: "2120"),
    TrainStation(name: "後龍", id: "2130"),
    TrainStation(name: "龍港", id: "2140"),
    TrainStation(name: "白沙屯", id: "2150"),
    TrainStation(name: "新埔", id: "2160"),
    TrainStation(name: "通霄", id: "2170"),
    TrainStation(name: "苑裡", id: "2180"),
    TrainStation(name: "造橋", id: "3140"),
    TrainStation(name: "豐富", id: "3150"),
    TrainStation(name: "苗栗", id: "3160"),
    TrainStation(name: "南勢", id: "3170"),
    TrainStation(name: "銅鑼", id: "3180"),
    TrainStation(name: "三義", id: "3190")
]

let taichungCityTrainStations: [TrainStation] = [
    TrainStation(name: "日南", id: "2190"),
    TrainStation(name: "大甲", id: "2200"),
    TrainStation(name: "臺中港", id: "2210"),
    TrainStation(name: "清水", id: "2220"),
    TrainStation(name: "沙鹿", id: "2230"),
    TrainStation(name: "龍井", id: "2240"),
    TrainStation(name: "大肚", id: "2250"),
    TrainStation(name: "追分", id: "2260"),
    TrainStation(name: "泰安", id: "3210"),
    TrainStation(name: "后里", id: "3220"),
    TrainStation(name: "豐原", id: "3230"),
    TrainStation(name: "栗林", id: "3240"),
    TrainStation(name: "潭子", id: "3250"),
    TrainStation(name: "頭家厝", id: "3260"),
    TrainStation(name: "松竹", id: "3270"),
    TrainStation(name: "太原", id: "3280"),
    TrainStation(name: "精武", id: "3290"),
    TrainStation(name: "臺中", id: "3300"),
    TrainStation(name: "五權", id: "3310"),
    TrainStation(name: "大慶", id: "3320"),
    TrainStation(name: "烏日", id: "3330"),
    TrainStation(name: "新烏日", id: "3340"),
    TrainStation(name: "成功", id: "3350")
]

let changhuaCountyTrainStations: [TrainStation] = [
    TrainStation(name: "彰化", id: "3360"),
    TrainStation(name: "花壇", id: "3370"),
    TrainStation(name: "大村", id: "3380"),
    TrainStation(name: "員林", id: "3390"),
    TrainStation(name: "永靖", id: "3400"),
    TrainStation(name: "社頭", id: "3410"),
    TrainStation(name: "田中", id: "3420"),
    TrainStation(name: "二水", id: "3430"),
    TrainStation(name: "源泉", id: "3431"),
]

let nantouCountyTrainStations: [TrainStation] = [
    TrainStation(name: "濁水", id: "3432"),
    TrainStation(name: "龍泉", id: "3433"),
    TrainStation(name: "集集", id: "3434"),
    TrainStation(name: "水里", id: "3435"),
    TrainStation(name: "車埕", id: "3436"),
]

let yunlinCountyTrainStations: [TrainStation] = [
    TrainStation(name: "林內", id: "3450"),
    TrainStation(name: "石榴", id: "3460"),
    TrainStation(name: "斗六", id: "3470"),
    TrainStation(name: "斗南", id: "3480"),
    TrainStation(name: "石龜", id: "3490"),
]

let chiayiTrainStations: [TrainStation] = [
    TrainStation(name: "大林", id: "4050"),
    TrainStation(name: "民雄", id: "4060"),
    TrainStation(name: "水上", id: "4090"),
    TrainStation(name: "南靖", id: "4100"),
    TrainStation(name: "嘉北", id: "4070"),
    TrainStation(name: "嘉義", id: "4080"),
]

let tainanCityTrainStations: [TrainStation] = [
    TrainStation(name: "後壁", id: "4110"),
    TrainStation(name: "新營", id: "4120"),
    TrainStation(name: "柳營", id: "4130"),
    TrainStation(name: "林鳳營", id: "4140"),
    TrainStation(name: "隆田", id: "4150"),
    TrainStation(name: "拔林", id: "4160"),
    TrainStation(name: "善化", id: "4170"),
    TrainStation(name: "南科", id: "4180"),
    TrainStation(name: "新市", id: "4190"),
    TrainStation(name: "永康", id: "4200"),
    TrainStation(name: "大橋", id: "4210"),
    TrainStation(name: "臺南", id: "4220"),
    TrainStation(name: "保安", id: "4250"),
    TrainStation(name: "仁德", id: "4260"),
    TrainStation(name: "中洲", id: "4270"),
    TrainStation(name: "長榮大學", id: "4271"),
    TrainStation(name: "沙崙", id: "4272")
]

let kaohsiungCityTrainStations: [TrainStation] = [
    TrainStation(name: "大湖", id: "4290"),
    TrainStation(name: "路竹", id: "4300"),
    TrainStation(name: "岡山", id: "4310"),
    TrainStation(name: "橋頭", id: "4320"),
    TrainStation(name: "楠梓", id: "4330"),
    TrainStation(name: "新左營", id: "4340"),
    TrainStation(name: "左營", id: "4350"),
    TrainStation(name: "內惟", id: "4360"),
    TrainStation(name: "美術館", id: "4370"),
    TrainStation(name: "鼓山", id: "4380"),
    TrainStation(name: "三塊厝", id: "4390"),
    TrainStation(name: "高雄", id: "4400"),
    TrainStation(name: "民族", id: "4410"),
    TrainStation(name: "科工館", id: "4420"),
    TrainStation(name: "正義", id: "4430"),
    TrainStation(name: "鳳山", id: "4440"),
    TrainStation(name: "後庄", id: "4450"),
    TrainStation(name: "九曲堂", id: "4460")
]

let pingtungCountyTrainStations: [TrainStation] = [
    TrainStation(name: "六塊厝", id: "4470"),
    TrainStation(name: "屏東", id: "5000"),
    TrainStation(name: "歸來", id: "5010"),
    TrainStation(name: "麟洛", id: "5020"),
    TrainStation(name: "西勢", id: "5030"),
    TrainStation(name: "竹田", id: "5040"),
    TrainStation(name: "潮州", id: "5050"),
    TrainStation(name: "崁頂", id: "5060"),
    TrainStation(name: "南州", id: "5070"),
    TrainStation(name: "鎮安", id: "5080"),
    TrainStation(name: "林邊", id: "5090"),
    TrainStation(name: "佳冬", id: "5100"),
    TrainStation(name: "東海", id: "5110"),
    TrainStation(name: "枋寮", id: "5120"),
    TrainStation(name: "加祿", id: "5130"),
    TrainStation(name: "內獅", id: "5140"),
    TrainStation(name: "枋山", id: "5160")
]

let taitungCountyTrainStations: [TrainStation] = [
    TrainStation(name: "大武", id: "5190"),
    TrainStation(name: "瀧溪", id: "5200"),
    TrainStation(name: "金崙", id: "5210"),
    TrainStation(name: "太麻里", id: "5220"),
    TrainStation(name: "知本", id: "5230"),
    TrainStation(name: "康樂", id: "5240"),
    TrainStation(name: "臺東", id: "6000"),
    TrainStation(name: "山里", id: "6010"),
    TrainStation(name: "鹿野", id: "6020"),
    TrainStation(name: "瑞源", id: "6030"),
    TrainStation(name: "瑞和", id: "6040"),
    TrainStation(name: "關山", id: "6050"),
    TrainStation(name: "海瑞", id: "6060"),
    TrainStation(name: "池上", id: "6070")
]

let hualienCountyTrainStations: [TrainStation] = [
    TrainStation(name: "富里", id: "6080"),
    TrainStation(name: "東竹", id: "6090"),
    TrainStation(name: "東里", id: "6100"),
    TrainStation(name: "玉里", id: "6110"),
    TrainStation(name: "三民", id: "6120"),
    TrainStation(name: "瑞穗", id: "6130"),
    TrainStation(name: "富源", id: "6140"),
    TrainStation(name: "大富", id: "6150"),
    TrainStation(name: "光復", id: "6160"),
    TrainStation(name: "萬榮", id: "6170"),
    TrainStation(name: "鳳林", id: "6180"),
    TrainStation(name: "南平", id: "6190"),
    TrainStation(name: "林榮新光", id: "6200"),
    TrainStation(name: "豐田", id: "6210"),
    TrainStation(name: "壽豐", id: "6220"),
    TrainStation(name: "平和", id: "6230"),
    TrainStation(name: "志學", id: "6240"),
    TrainStation(name: "吉安", id: "6250"),
    TrainStation(name: "花蓮", id: "7000"),
    TrainStation(name: "北埔", id: "7010"),
    TrainStation(name: "景美", id: "7020"),
    TrainStation(name: "新城", id: "7030"),
    TrainStation(name: "崇德", id: "7040"),
    TrainStation(name: "和仁", id: "7050"),
    TrainStation(name: "和平", id: "7060")
]

let yilanCountyTrainStations: [TrainStation] = [
    TrainStation(name: "漢本", id: "7070"),
    TrainStation(name: "武塔", id: "7080"),
    TrainStation(name: "南澳", id: "7090"),
    TrainStation(name: "東澳", id: "7100"),
    TrainStation(name: "永樂", id: "7110"),
    TrainStation(name: "蘇澳", id: "7120"),
    TrainStation(name: "蘇澳新", id: "7130"),
    TrainStation(name: "新馬", id: "7140"),
    TrainStation(name: "冬山", id: "7150"),
    TrainStation(name: "羅東", id: "7160"),
    TrainStation(name: "中里", id: "7170"),
    TrainStation(name: "二結", id: "7180"),
    TrainStation(name: "宜蘭", id: "7190"),
    TrainStation(name: "四城", id: "7200"),
    TrainStation(name: "礁溪", id: "7210"),
    TrainStation(name: "頂埔", id: "7220"),
    TrainStation(name: "頭城", id: "7230"),
    TrainStation(name: "外澳", id: "7240"),
    TrainStation(name: "龜山", id: "7250"),
    TrainStation(name: "大溪", id: "7260"),
    TrainStation(name: "大里", id: "7270"),
    TrainStation(name: "石城", id: "7280")
]

let chengzhuiLineTrainStations: [TrainStation] = [
    TrainStation(name: "追分", id: "2260"),
    TrainStation(name: "成功", id: "3350")
]

let pingxiLineTrainStations: [TrainStation] = [
    TrainStation(name: "三貂嶺", id: "7330"),
    TrainStation(name: "大華", id: "7331"),
    TrainStation(name: "十分", id: "7332"),
    TrainStation(name: "望古", id: "7333"),
    TrainStation(name: "嶺腳", id: "7334"),
    TrainStation(name: "平溪", id: "7335"),
    TrainStation(name: "菁桐", id: "7336")
]

let shenaoLineTrainStations: [TrainStation] = [
    TrainStation(name: "瑞芳", id: "7360"),
    TrainStation(name: "八斗子", id: "7362"),
    TrainStation(name: "海科館", id: "7361")
]

let liujiaLineTrainStations: [TrainStation] = [
    TrainStation(name: "竹中", id: "1193"),
    TrainStation(name: "六家", id: "1194")
]

let neiwanLineTrainStations: [TrainStation] = [
    TrainStation(name: "北新竹", id: "1190"),
    TrainStation(name: "千甲", id: "1191"),
    TrainStation(name: "新莊", id: "1192"),
    TrainStation(name: "竹中", id: "1193"),
    TrainStation(name: "上員", id: "1201"),
    TrainStation(name: "榮華", id: "1202"),
    TrainStation(name: "竹東", id: "1203"),
    TrainStation(name: "橫山", id: "1204"),
    TrainStation(name: "九讚頭", id: "1205"),
    TrainStation(name: "合興", id: "1206"),
    TrainStation(name: "富貴", id: "1207"),
    TrainStation(name: "內灣", id: "1208")
]

let jijiLineTrainStations: [TrainStation] = [
    TrainStation(name: "二水", id: "3430"),
    TrainStation(name: "源泉", id: "3431"),
    TrainStation(name: "濁水", id: "3432"),
    TrainStation(name: "龍泉", id: "3433"),
    TrainStation(name: "集集", id: "3434"),
    TrainStation(name: "水里", id: "3435"),
    TrainStation(name: "車埕", id: "3436")
]

let shalunLineTrainStations: [TrainStation] = [
    TrainStation(name: "中洲", id: "4270"),
    TrainStation(name: "長榮大學", id: "4271"),
    TrainStation(name: "沙崙", id: "4272")
]
