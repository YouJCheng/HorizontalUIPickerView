//
//  ViewController.swift
//  HorizontalUIPickerView
//
//  Created by Yu-J.Cheng on 2018/4/12.
//  Copyright © 2018年 YuChienCheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var horizontalPickerView = UIPickerView()
    var arrDatasource = [Int]()
    var rotationAngle: CGFloat!
    var height:CGFloat = 30
    var width:CGFloat = 30
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0...9 {
            arrDatasource.append(i)
        }

        rotationAngle = -90 * .pi/180
        let y = horizontalPickerView.frame.origin.y
        horizontalPickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        horizontalPickerView.frame = CGRect(x: -100, y: y, width: view.frame.width+200, height: 100)
        view.addSubview(horizontalPickerView)
        horizontalPickerView.delegate = self

        createHighlightView()
    }

    func createHighlightView() {
        let highlightView = UIView(frame: CGRect.zero)
        highlightView.backgroundColor = UIColor.red.withAlphaComponent(0.2)

        /*
         Now lets programmatically add constraints
         */
        highlightView.translatesAutoresizingMaskIntoConstraints = false
        horizontalPickerView.addSubview(highlightView)

        //HightLight View's width
        highlightView.addConstraint(NSLayoutConstraint(item: highlightView,
                                                       attribute: .width,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: width))

        //HightLight View's height
        highlightView.addConstraint(NSLayoutConstraint(item: highlightView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: height))

        //HightLight View should be bang center-aligned with pickerView
        horizontalPickerView.addConstraint(NSLayoutConstraint(item: highlightView,
                                                    attribute: .centerX,
                                                    relatedBy: .equal,
                                                    toItem: horizontalPickerView,
                                                    attribute: .centerX,
                                                    multiplier: 1,
                                                    constant: 0))
        horizontalPickerView.addConstraint(NSLayoutConstraint(item: highlightView,
                                                    attribute: .centerY,
                                                    relatedBy: .equal,
                                                    toItem: horizontalPickerView,
                                                    attribute: .centerY,
                                                    multiplier: 1,
                                                    constant: 0))
    }


}
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrDatasource.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //no need to reload
        //do whatever else you want
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        /*
         Just return a `UILabel`. No need to put it in a `UIView`.
         Nothing special either, just slap text into it
         */

        var label = view as? UILabel

        if label == nil {
            label = UILabel()
            label!.transform = CGAffineTransform(rotationAngle: -rotationAngle)

            //All the rest are safe force unwraps so chill tf out
            label!.frame = CGRect(x: 0, y: 0, width: width, height: height)
            label!.textAlignment = .center
            label!.font = UIFont.systemFont(ofSize: 30)
        }

        label!.text = String(arrDatasource[row])

        return label!
    }

}
