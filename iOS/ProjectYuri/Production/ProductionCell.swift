//
//  ProductionCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/13.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ProductionCell: ZSTableViewCell {
    let input = BehaviorRelay(value: ProductionModel())
    let output = PublishRelay<ProductionModel>()
}

class ProductionCell0: ProductionCell {
    
    func setData(data: ProductionModel) {
          self.titleLab.text = data.title
          self.textField.text = data.content
          self.textField.placeholder = data.detail
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind(onNext: self.setData)
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { [unowned self] in self.input.value.content = $0 })
            .map{ [unowned self] _ in self.input.value }
            .bind(to: output)
            .disposed(by: disposeBag)
    }
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        return textField
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(textField)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
        
    }
}

class ProductionCell1: ProductionCell {
    
    func setData(data: ProductionModel) {
        self.titleLab.text = data.title
        self.textView.text = data.content
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind(onNext: self.setData)
            .disposed(by: disposeBag)
        
        textView.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { [unowned self] in self.input.value.content = $0 })
            .map{ [unowned self] _ in self.input.value }
            .bind(to: output)
            .disposed(by: disposeBag)
    }
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.groupTableViewBackground
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(textView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(200)
        }
        
    }
}

class ProductionCell2: ProductionCell {
    
    func setData(data: ProductionModel) {
        self.titleLab.text = data.title
        if let category = data.category {
            self.groupBtn.selectedSegmentIndex = self.categoryArray.firstIndex(of: category)!
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind(onNext: self.setData)
            .disposed(by: disposeBag)
        
        groupBtn.rx.selectedSegmentIndex
            .filter{ [unowned self] in  $0 >= 0 && $0 < self.categoryArray.count }
            .do(onNext: { [unowned self] in self.input.value.category = self.categoryArray[$0] })
            .map{ [unowned self] _ in self.input.value }
            .bind(to: output)
            .disposed(by: disposeBag)
    }
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let categoryArray: [ProductionCategory] = ProductionCategory.allCases
    lazy var groupBtn: UISegmentedControl = {
        let groupBtn = UISegmentedControl(items: categoryArray.map{$0.displayValue})
        groupBtn.tintColor = UIColor.main
        return groupBtn
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(groupBtn)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        groupBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
    }
}

class ProductionCell3: ProductionCell {
    
    func setData(data: ProductionModel) {
        self.titleLab.text = data.title
        self.imgBtn.sd_setImage(with:  URL(string: data.coverUrl), for: .normal, placeholderImage: UIImage(named: "taking_pictures"), options: .refreshCached, completed: nil)
    }
    
    func selectImage() {
        let pm = MLDPhotoManager(self.imgBtn, withCameraImages: { images in
            let image = images?.first as? UIImage
            self.imgBtn.setImage(image, for: .normal)
            self.output.accept(ProductionModel(image: image))
        }, withAlbumArray: { images in
            let image = images?.first as? UIImage
            self.imgBtn.setImage(image, for: .normal)
            self.output.accept(ProductionModel(image: image))
        }, cancel: nil)
        pm?.maxPhotoCount = 1
        pm?.showAlert(self.imgBtn)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind(onNext: self.setData)
            .disposed(by: disposeBag)
        
        imgBtn.rx.tap
            .bind(onNext: self.selectImage)
            .disposed(by: disposeBag)
        
    }
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let imgBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.main, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "taking_pictures"), for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        return button
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(imgBtn)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        imgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
    }
    
}

class ProductionCell4: ProductionCell {
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .map{ $0.title }
            .bind(to: titleLab.rx.text)
            .disposed(by: disposeBag)
        
        addBtn.rx.tap
            .map{ ProductionModel() }
            .bind(to: output)
            .disposed(by: disposeBag)
        
    }
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let addBtn: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = UIColor.main
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(addBtn)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        addBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLab.snp.trailing).offset(10)
            make.centerY.equalTo(titleLab)
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.trailing.lessThanOrEqualTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
    }
}

class ProductionCell5: ZSTableViewCell {
    
    let input = BehaviorRelay(value: ProductionModel())
    let output = BehaviorRelay(value: ProductionModel())
    
    func setData(data: ProductionModel) {
        self.imgBtn.sd_setImage(with: URL(string: data.coverUrl), for: .normal, placeholderImage: UIImage(named: "taking_pictures"), options: .refreshCached, completed: nil)
        self.nameTextField.text = data.title
        self.cvTextField.text = data.content
    }
    
    func selectImage() {
        let pm = MLDPhotoManager(self.imgBtn, withCameraImages: { images in
            let image = images?.first as? UIImage
            self.imgBtn.setImage(image, for: .normal)
            self.output.value.image = image
            self.output.accept(self.output.value)
        }, withAlbumArray: { images in
            let image = images?.first as? UIImage
            self.imgBtn.setImage(image, for: .normal)
            self.output.value.image = image
            self.output.accept(self.output.value)
        }, cancel: nil)
        pm?.maxPhotoCount = 1
        pm?.showAlert(self.imgBtn)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind(onNext: self.setData)
            .disposed(by: disposeBag)
        
        imgBtn.rx.tap
            .bind(onNext: self.selectImage)
            .disposed(by: disposeBag)
        
        nameTextField.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { [unowned self] in self.output.value.title = $0 })
            .map { [unowned self] _ in self.output.value }
            .bind(to: self.output)
            .disposed(by: disposeBag)
        
        cvTextField.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { [unowned self] in self.output.value.content = $0 })
            .map { [unowned self] _ in self.output.value }
            .bind(to: self.output)
            .disposed(by: disposeBag)
    }
    
    let imgBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.main, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "taking_pictures"), for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        return button
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.placeholder = "角色名"
        return textField
    }()
    
    let cvTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.placeholder = "CV"
        return textField
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(imgBtn)
        contentView.addSubview(nameTextField)
        contentView.addSubview(cvTextField)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        imgBtn.snp.makeConstraints { (make) in
            make.top.leading.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.size.equalTo(CGSize(width: 70, height: 70))
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.leading.equalTo(imgBtn.snp.trailing).offset(10)
            make.height.equalTo(30)
        }
        
        cvTextField.snp.makeConstraints { (make) in
            make.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.leading.equalTo(imgBtn.snp.trailing).offset(10)
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
            make.height.equalTo(30)
        }
    }
}
