//
//  ProductionCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/29.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductionDetailCell0: ZSExpandableCell {
    
    let dataSource = PublishRelay<ProductionDetailModel<Production>>()
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .map{ $0.data }
            .map{"\($0.desp) \($0.desp) \($0.desp) \($0.desp) \n\n\($0.desp) \($0.desp) \($0.desp) \($0.desp)"}
            .bind(to:contentLab.rx.text)
            .disposed(by: disposeBag)
        
        dataSource
            .bind { [unowned self] in self.isExpanded = $0.isExpanded }
            .disposed(by: disposeBag)
    }
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        expandBtn.backgroundColor = .clear
        
        expandableView.addSubview(contentLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        contentLab.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
}

class ProductionDetailCell1: ZSExpandableCell {
    
    let dataSource = PublishRelay<ProductionDetailModel<Production>>()
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .map{ $0.data }
            .map{"\($0.coverUrl) \n\n\($0.coverUrl) \n\n\($0.coverUrl) \n\n\($0.coverUrl) \n\n\($0.coverUrl) \n\n\($0.coverUrl) \n\n\($0.coverUrl) \n\n\($0.coverUrl)"}
            .bind(to:contentLab.rx.text)
            .disposed(by: disposeBag)
        
        dataSource
            .bind { [unowned self] in self.isExpanded = $0.isExpanded }
            .disposed(by: disposeBag)
    }
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        expandBtn.backgroundColor = .clear
        
        expandableView.addSubview(contentLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        contentLab.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
}

class ProductionDetailCell2: ZSTableViewCell {
    
    let dataSource = PublishRelay<ProductionDetailModel<Production>>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.text = "点击查看详细"
        label.numberOfLines = 0
        return label
    }()
    
    let arrowImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ipad_player_setup_arrow")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        contentView.addSubview(contentLab)
        contentView.addSubview(arrowImg)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        contentLab.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.left.equalTo(contentLab.snp.right).offset(10)
            make.centerY.equalTo(contentLab)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
    }
}

class ProductionDetailCell3: ZSTableViewCell {
    
    let dataSource = PublishRelay<ProductionDetailModel<Production>>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
    let moreBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("更多")
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    let arrowImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ipad_player_setup_arrow")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    var charactersArray: [ZSUserView] = {
        var arr = [ZSUserView]()
        for _ in 0..<6 {
            let view = ZSUserView(iconSize: CGSize(width: 40, height: 40), titleFont: UIFont.systemFont(ofSize: 10), contentFont: UIFont.systemFont(ofSize: 10))
            view.iconImg.backgroundColor = UIColor.random
            view.titleLab.text = String.random(len: 8)
            view.contentLab.text = "CV: \(String.random(len: 8))"
            arr.append(view)
        }
        return arr
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        contentView.addSubview(moreBtn)
        contentView.addSubview(arrowImg)
        contentView.addSubview(mainView)
        charactersArray.forEach { mainView.addSubview($0) }
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        moreBtn.snp.makeConstraints { (make) in
            make.top.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.size.equalTo(CGSize(width: 25, height: 15))
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.left.equalTo(moreBtn.snp.right)
            make.centerY.equalTo(moreBtn)
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        mainView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.top.equalTo(moreBtn.snp.bottom).offset(10)
        }
        
        charactersArray.snp.distributeSudokuViews(fixedLineSpacing: 0, fixedInteritemSpacing: 0, warpCount: 2)
    }
}


