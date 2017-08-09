//: Playground - noun: a place where people can play

import UIKit


class CalcTax {
    func taxAmount(subtotal: Double) -> Double {
        return 0.0
    }
}

class CalcUSTax: CalcTax {
    override func taxAmount(subtotal: Double) -> Double {
        return 0.08875 * subtotal
    }
}

class CalcJPTax: CalcTax {
    override func taxAmount(subtotal: Double) -> Double {
        return 0.08 * subtotal
    }
}

enum Country {
    case us, jp
    func calcTax() -> CalcTax {
        switch self {
        case .us:
            return CalcUSTax()
        case .jp:
            return CalcJPTax()
        }
    }
}

let calcUsTax = Country.us.calcTax()
let calcJpTax = Country.jp.calcTax()

[calcUsTax, calcJpTax]
    .flatMap { $0 }
    .map { $0.taxAmount(subtotal: 100) }

//