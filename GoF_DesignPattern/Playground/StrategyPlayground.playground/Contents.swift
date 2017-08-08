//: Playground - noun: a place where people can play

import Foundation

/**
 *  会計モデル
 */
struct VoucherModel {
    var price1 = 0.0
    var name = ""
    let identifier: String
    var items: [Item]
    var discExs: [DiscEx]
    var orderDiscExs: [OrderDiscEx]
    var subTotal: Double {
        return items.reduce(0.0) { $0 + $1.price }
    }
    
    var total: Double {
        let percent = discExs.filter { $0.type == .percent }.reduce(0.0) { $0 + $1.value * subTotal / 100 }
        return subTotal - discExs.filter { $0.type == .price }.reduce(0.0) { $0 + $1.value } - percent
    }
    
    init() {
        self.identifier = NSUUID().uuidString
        self.name = "TKO" + self.identifier
        self.items = [Item]()
        self.discExs = [DiscEx]()
        self.orderDiscExs = [OrderDiscEx]()
    }
}

struct Item {
    var price = 0.0
    var name = ""
    var identifier: String
    
    init(price: Double, name: String) {
        self.price = price
        self.name = name
        self.identifier = NSUUID().uuidString
    }
}

enum DiscExType {
    case price, percent
}

protocol DiscExsable {
    var name: String { get set }
    var type: DiscExType { get set }
    var value: Double { get set }
}

struct DiscEx {
    var value: Double
    var name = ""
    var type: DiscExType
}

struct OrderDiscEx: DiscExsable {
    var itemName = ""
    var itemIdentifier = ""
    
    var value: Double
    var name = ""
    var type: DiscExType
}

/**
 *  割引割増計算をするI/F
 */
protocol DiscExCalc {
    associatedtype DataType
    associatedtype CheckData
    /**
     按分計算する
     
     - parameter check: 対象会計
     
     - returns: 按分合計結果　全体の金額から引く数　チェック用
     */
    func execute(check: CheckData) -> CheckData
    /**
     割引割増計算ロジック
     
     - parameter total:  総額
     - parameter price:  按分対象
     - parameter discEx: 割引割増額
     
     - returns: 按分積み上げ値(総額に差ができた時に使用する)
     */
    func divide(at total: DataType, into price: DataType, discEx: DataType) -> DataType
}

/**
 *  値割
 */
struct PriceDiscExCalc: DiscExCalc {
    
    func execute(check: VoucherModel) -> VoucherModel {
        var innerCheck = check
        let discExs = check.discExs.filter { $0.type == .price }
        discExs.forEach { discEx in
            innerCheck.items.forEach { item in
                let div = divide(at: check.subTotal, into: item.price, discEx: discEx.value)
                
                let orderDicsEx = OrderDiscEx(itemName: item.name, itemIdentifier: item.identifier, value: div, name: item.name, type: .price)
                innerCheck.orderDiscExs.append(orderDicsEx)
            }
        }
        return innerCheck
    }
    
    func divide(at total: Double, into price: Double, discEx: Double) -> Double {
        // 計算ロジック　price / total * 割引額
        return price / total * discEx
    }
}

/**
 *  %割を行う
 */
struct PercentDiscExCalc: DiscExCalc {
    
    func execute(check: VoucherModel) -> VoucherModel {
        var innerCheck = check
        let discExs = check.discExs.filter { $0.type == .percent }
        
        discExs.forEach { discEx in
            innerCheck.items.forEach { item in
                let div = divide(at: check.subTotal, into: item.price, discEx: discEx.value)
                let orderDicsEx = OrderDiscEx(itemName: item.name, itemIdentifier: item.identifier, value: div, name: item.name, type: .price)
                innerCheck.orderDiscExs.append(orderDicsEx)
            }
        }
        
        return innerCheck
    }
    
    func divide(at total: Double, into price: Double, discEx: Double) -> Double {
        // price * percent / 100
        return price * discEx / 100
    }
}

struct AnyDiscExCalc<CheckData, DataType>: DiscExCalc {
    
    let box: (CheckData) -> CheckData
    let calcAlgo: (DataType, DataType, DataType) -> DataType
    init<U: DiscExCalc>(_ calc: U) where U.CheckData == CheckData, U.DataType == DataType {
        self.box = { check in calc.execute(check: check) }
        self.calcAlgo = { (total, price, discex) in calc.divide(at: total, into: price, discEx: discex) }
    }
    
    func execute(check: CheckData) -> CheckData {
        return self.box(check)
    }
    
    func divide(at total: DataType, into price: DataType, discEx: DataType) -> DataType {
        return self.calcAlgo(total, price, discEx)
    }
}

var voucher0 = VoucherModel()
voucher0.items.append(Item(price: 10.00, name: "Coffee"))
voucher0.items.append(Item(price: 10.00, name: "Cheese cake"))
voucher0.items.append(Item(price: 10.00, name: "Ice Tea"))
voucher0.items.append(Item(price: 10.00, name: "Ice latte"))

voucher0.discExs.append(DiscEx(value: 2.5, name: "$2.5disc", type: .price))
voucher0.discExs.append(DiscEx(value: 3.0, name: "3%disc", type: .percent))

let dicexCalc0 = AnyDiscExCalc(PriceDiscExCalc())
let dicexCalc1 = AnyDiscExCalc(PercentDiscExCalc())

[dicexCalc0, dicexCalc1].map { $0.execute(check: voucher0) }

let array = [dicexCalc0]

let results = array.map {
    return $0.execute(check: voucher0)
}

print("total: \(voucher0.total)")
print("-------割引$----------")
dicexCalc0.execute(check: voucher0).orderDiscExs.forEach {
    print("name: \($0.itemName), value: \($0.value)")
}
print("-------割引%----------")
dicexCalc1.execute(check: voucher0).orderDiscExs.forEach {
    print("name: \($0.itemName), value: \($0.value)")
}

results.forEach { result in
    print("############################")
    result.items.forEach { print("\($0.name) \($0.price)") }
    result.discExs.forEach { print("\($0.name): \($0.value)") }
    print("subtotal: \(result.subTotal)")
    print("total: \(result.total)")
    print("############################")
}

let value0 = dicexCalc0.execute(check: voucher0)
let value1 = dicexCalc1.execute(check: voucher0)
//voucher0.orderDiscExs.forEach {
    //print(("\($0.value)"))
//}
print(value0.total)

