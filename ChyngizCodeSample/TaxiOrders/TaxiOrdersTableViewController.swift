//
//  TaxiOrdersTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 27.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import CoreLocation

class TaxiOrdersTableViewController:UIViewController, UITableViewDelegate,UITableViewDataSource,CustomSegmentedControlDelegate {
    func changeToIndex(index: Int) {
        reload(index: index)
    }
    var mainview:TaxiOrdersView {
        return self.view as! TaxiOrdersView
    }
    
    var cellid = "cellid"
    var ViewModel : TableViewTaxiOrdersModelType?
    var module = TaxiOrdersViewModel()
   


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addview()
        ViewModel = module
        navigationController?.navigationBar.barTintColor = maincolor
    
        DispatchQueue.main.async {
            self.reload(index: 0)
        }
        
        
          mainview.tableview.bounces = false
    }
  
    
    func addview() {
        self.view = TaxiOrdersView(frame: UIScreen.main.bounds)
        mainview.tableview.dataSource = self
        mainview.tableview.delegate = self
        mainview.tableview.register(TaxiOrdersTableViewCell.self, forCellReuseIdentifier: cellid)
        mainview.tableview.allowsSelection = false
        mainview.tableview.estimatedRowHeight = 70
        mainview.tableview.rowHeight = UITableView.automaticDimension
        
        }
    
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    @objc func reload (index:Int) {
        var mainurl : String!
        switch index {
        case 0:
            mainurl = "/get-shared-orders/"
        case 1:
            mainurl = "/get-own-orders/"
        default:
            break
        }
        getcharorders.get(url: mainurl!) { (info) in
            if let info = info {
                self.module.chats = info
                self.mainview.tableview.reloadData()
            }
          
        }
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel?.numofrows ?? 0
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as? TaxiOrdersTableViewCell
        guard let tableViewCell = cell, let viewModel = ViewModel else {
            return UITableViewCell()
        }
        let cellviewmodel = ViewModel?.cellViewModile(forIndexPath: indexPath)
        tableViewCell.viewModel = cellviewmodel
        
        return tableViewCell
    }
    
  

}

