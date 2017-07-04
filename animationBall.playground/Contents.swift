//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let v = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
v.backgroundColor = .red

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = v

let b = BallView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)), using: .green, with: 3)
b.backgroundColor = .white
v.addSubview(b)
b.startAnimating()
