//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

var str = "Hello, playground"

let base = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
base.backgroundColor = .white
PlaygroundPage.current.liveView = base

let blueView = UIView(frame: CGRect(x: 300, y: 100, width: 100, height: 100))
blueView.backgroundColor = .blue
base.addSubview(blueView)

let redView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
redView.backgroundColor = .red
base.addSubview(redView)

let centerX = blueView.center.x
let redCenterX = redView.center.x

blueView.center.x = -(blueView.frame.width / 2.0)
redView.center.x = -(redView.frame.width / 2.0)

UIView.animate(withDuration: 3, delay: 0, options: [ .curveEaseInOut], animations: {
    blueView.center.x += redCenterX + redView.frame.width / 2.0
    redView.center.x += centerX + blueView.frame.width / 2.0
}, completion: nil)
