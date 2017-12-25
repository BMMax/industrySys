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
