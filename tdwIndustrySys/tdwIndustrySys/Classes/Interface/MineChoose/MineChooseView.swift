//
//  MineChooseView.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
class MineChooseView: UIView, ViewProtocol{
    var viewModel: ViewModelProtocol?
    var operation: ViewOpetation?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.random
        if #available(iOS 11.0, *) {
            UITableView.appearance().contentInsetAdjustmentBehavior = .never
        }
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.mb
            .add(into: self)
            .layout {
                $0.frame = self.bounds
            
            }
            .then {
                $0.delegate = self
                $0.dataSource = self
                $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                $0.header {
                    debugPrint("刷新------")
                    delay(4, closure: {
                        table.changeHeader(to: .normal(.success, 0.5))
                    })
                }
                
                $0.footer {
                    debugPrint("上拉刷新")
                    delay(4, closure: {
                        table.changeFooter(to: .noMoreData)
                    })
                }
            }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension MineChooseView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "index---\(indexPath.row)"
        return cell ?? UITableViewCell()
    }
}
