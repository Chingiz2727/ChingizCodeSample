//
//  TaxiOrdersView.swift
//  ChyngizCodeSample
//
//  Created by Чингиз on 1/17/19.
//  Copyright © 2019 Чингиз. All rights reserved.
//

import Foundation
import UIKit


class TaxiOrdersView: UIView {
    var codeSegmented : CustomSegmentedControl = CustomSegmentedControl()
    let tableview = UITableView()
    var items : [String] = []

    override init(frame: CGRect) {
        super.init(frame:frame)
        addview()
    }
    func addview() {
        self.addSubview(codeSegmented)
        self.addSubview(tableview)
        tableview.setAnchor(top: codeSegmented.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        codeSegmented.setButtonTitles(buttonTitles: [""])
        codeSegmented.setAnchor(top: self.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.frame.width, height: 50)
        self.codeSegmented.label2.isHidden = true
        CheckForChats.check { (state) in
            switch state!.showChat! {
            case true:
                self.items = ["Общий чат","Мой таксопарк"]
                self.codeSegmented.label2.isHidden = false
            case false :
                self.items = ["Общий чат"]
                self.codeSegmented.label2.isHidden = true
            }
            self.codeSegmented.label1.text = "\(state?.amountShared ?? 0)"
            self.codeSegmented.label2.text = "\(state?.amountOwn ?? 0)"
            self.codeSegmented.setButtonTitles(buttonTitles: self.items)
            self.codeSegmented.backgroundColor = .clear
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
