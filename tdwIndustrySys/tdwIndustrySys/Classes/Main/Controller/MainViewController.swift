//
//  MainViewController.swift
//  TianDW
//
//  Created by B2B-IOS on 17/2/7.
//  Copyright © 2017年 tiandiwang. All rights reserved.
//

import UIKit


class MainViewController: UITabBarController {
    enum ChildVCType {
        case mineChoose // 自选
        case marketQuotation // 行情
        case information // 资讯
        case transaction // 交易
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var attrs = [NSAttributedStringKey: NSObject]()
        attrs[NSAttributedStringKey.foregroundColor] = UIColor.cyan        // 设置tabBar字体颜色
        UITabBarItem.appearance().setTitleTextAttributes(attrs, for:.selected)

        addChildVC(.mineChoose, image: "_0003_shouyea", selectedImage: "_0004_shouyeb")
        addChildVC(.marketQuotation, image: "_0005_qiugoua", selectedImage: "_0001_qiugoub")
        addChildVC(.information, image: "_0002_zhongxa", selectedImage: "_0000_zhongxb")
        addChildVC(.information, image: "_0002_zhongxa", selectedImage: "_0000_zhongxb")
        view.backgroundColor = UIColor.white
        navigationController?.view.backgroundColor = UIColor.white
        selectedViewController = childViewControllers.first

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    private func addChildVC(_ type: ChildVCType, image: String, selectedImage: String){
        
        var childVc: UIViewController?
        switch type {
        case .mineChoose:
            childVc = MineChooseController()
        case .marketQuotation:
            childVc = MarketQuotationController()
        case .information:
            childVc = InfomationController()
        case .transaction:
            childVc = TransactionController()
        }
        guard let vc = childVc else {return}
        addChildViewController(vc)
        childVc?.tabBarItem.image = UIImage(named: image)
        childVc?.tabBarItem.selectedImage = UIImage(named: selectedImage)
    

    }
}





