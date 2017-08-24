//: Playground - noun: a place where people can play

import UIKit

class ResoureData {
    let type: KaradaType
    var isEnabled = false
    
    init(type: KaradaType) {
        self.type = type
    }
}

enum KaradaType {
    case walk
    case weight
    case bloodPressure
    case bloodSugar
    
    var providers: [ResourceProvider] {
        switch self {
        case .walk:
            return [.kencomAuto, .welby]
        case .weight, .bloodPressure, .bloodSugar:
            return [.welby]
        }
    }
    
    func createDataSource() -> [ResoureData] {
        return self.providers.map({ _ in
            return ResoureData(type: self) })
    }
}

enum ResourceProvider: Int {
    case kencomAuto = 0
    case welby
    
    var name: String {
        switch self {
        case .kencomAuto:
            return "## health care ##"
        case .welby:
            return "## Welby ##"
        }
    }
}
[1, 2].enumerated()
let type = KaradaType.walk
type.providers.map { $0.name }.forEach { print($0) }

let data2 = type.createDataSource()
data2.forEach { print($0.isEnabled) }

for (index, data) in data2.enumerated() {
    print(data)
    if index == 0 {
        data.isEnabled = true
    }
}
data2.forEach { print($0.isEnabled) }




