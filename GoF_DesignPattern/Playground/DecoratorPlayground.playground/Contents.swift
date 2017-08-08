//: Playground - noun: a place where people can play

import Foundation

class PrintImage {
    func renderImage() {
        print("image")
    }
}

class VoucherImage: PrintImage {
    override func renderImage() {
        for idx in 0..<10 {
            print("item: \(idx)")
        }
    }
}

class DecolateImage: PrintImage {
    let image: PrintImage
    init(image: PrintImage) {
        self.image = image
    }
    
    override func renderImage() {
        print("###########")
        image.renderImage()
        print("###########")

    }
}

class StoreInfoImage: DecolateImage {
    override func renderImage() {
        print("Store name")
        print("Tel: xxx-xxx-xxxx")
        image.renderImage()
    }
}

class PaymentImage: DecolateImage {
    override func renderImage() {
        image.renderImage()
        print("cash $12.34")
    }
}

PaymentImage(image:
    StoreInfoImage(image:
        DecolateImage(image:
            BodyImage()))).renderImage()
