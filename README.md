# industrySys

> ## 网络请求
    AlamofireClient()
            .request(MineChooseRequest())
            .load(load)
            .respond(warn: AlterView.showAlter()){ (dict) in
                debugPrint(dict)
            }
> 
> ## UI
    grayView.mb
            .add(into: self)
            .then {
               $0.alpha = 0.2
               $0.backgroundColor = UIColor.black }
            .layout {GrayViewLayout(view: $0).layoutMaker()};


> ## 刷新
    table.mb
            .add(into: self)
            .layout { $0.frame = self.bounds }
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
