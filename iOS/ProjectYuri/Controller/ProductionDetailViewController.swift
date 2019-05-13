//
//  ProductionViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/28.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage
import ZSUtils

class ProductionDetailViewController: ZSViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(ProductionDetailCell0.self)
        tableView.zs.register(ProductionDetailCell1.self)
        tableView.zs.register(ProductionDetailCell2.self)
        tableView.zs.register(ProductionDetailCell3.self)
        return tableView
    }()
    
    let headerView: ProductionDetailHeaderView = {
        let headerView = ProductionDetailHeaderView()
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: height)
        return headerView
    }()
    
    let visualView: ZSVisualEffectView = {
        let visualView = ZSVisualEffectView()
        return visualView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        rightBarButtonItem = UIBarButtonItem(target: nil, action: nil, title: "编辑", font: nil, titleColor: .white, highlightedColor: .white, titleEdgeInsets: .zero)
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        tableView.backgroundView = visualView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    let dataSource = BehaviorRelay(value: Production())
    
    lazy var sectionedDataSource: [ProductionDetailModel<Production>] = [
        ProductionDetailModel(dataSource.value),
        ProductionDetailModel(dataSource.value),
        ProductionDetailModel(dataSource.value),
        ProductionDetailModel(dataSource.value),
        ]
    
    override func bindViewModel() {
        super.bindViewModel()
        
        rightBarButtonItem?.button?.rx.tap
            .bind{ [weak self] in guard let `self` = self else { return }
                self.gotoProductionViewController(self.dataSource.asObservable())
                print("\($0) rightBarButtonItem")
            }
            .disposed(by: disposeBag)
        
        dataSource
            .bind{ [weak self] in guard let `self` = self else { return }
                self.visualView.backgroundImg.sd_setImage(with: URL(string: $0.coverUrl))
                self.title = $0.name
            }
            .disposed(by: disposeBag)
        
        dataSource
            .bind(to: headerView.dataSource)
            .disposed(by: headerView.disposeBag)
    }

}

extension ProductionDetailViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedDataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = sectionedDataSource[indexPath.section]
        switch indexPath.section {
        case 0:
            let cell = tableView.zs.dequeueReusableCell(ProductionDetailCell0.self, for: indexPath)
            Observable.of(data).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
            cell.expandAction
                .bind {
                    data.isExpanded = $0
                    tableView.reloadSections([indexPath.section], with: .fade)
                }
                .disposed(by: cell.disposeBag)
            return cell
        case 1:
            let cell = tableView.zs.dequeueReusableCell(ProductionDetailCell1.self, for: indexPath)
            Observable.of(data).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
            cell.expandAction
                .bind {
                    data.isExpanded = $0
                    tableView.reloadSections([indexPath.section], with: .fade)
                }
                .disposed(by: cell.disposeBag)
            return cell
        case 2:
            let cell = tableView.zs.dequeueReusableCell(ProductionDetailCell2.self, for: indexPath)
            Observable.of(data).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
            return cell
        case 3:
            let cell = tableView.zs.dequeueReusableCell(ProductionDetailCell3.self, for: indexPath)
            Observable.of(data).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
            return cell
        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ProductionDetailSectionHeaderView()
        switch section {
        case 0:
            Observable.of("介绍").bind(to: view.dataSource).disposed(by: view.disposeBag)
        case 1:
            Observable.of("信息").bind(to: view.dataSource).disposed(by: view.disposeBag)
        case 2:
            Observable.of("制作人员").bind(to: view.dataSource).disposed(by: view.disposeBag)
        case 3:
            Observable.of("角色").bind(to: view.dataSource).disposed(by: view.disposeBag)
        default: break
        }
        return view
    }
}

extension ProductionDetailViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: .gray), for: .default)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: .main), for: .default)
    }
}
