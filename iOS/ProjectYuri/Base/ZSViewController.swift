//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by 張帥 on 2018/11/30.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ZSViewController: UIViewController, ViewType {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        buildSubViews()
        makeConstraints()
        bindViewModel()
    }
    
    func buildSubViews() -> Void { }
    func makeConstraints() -> Void { }
    func bindViewModel() -> Void { }
    
}

extension ZSViewController {
    func gotoOwnerViewController(_ owner: Observable<RepositoryOwner>) {
        let vc = OwnerViewController()
        owner.bind(to: vc.dataSource).disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoFavouritesViewController(_ favourites: Observable<[Repository]>) {
        let vc = FavouritesViewController()
        favourites.bind(to: vc.dataSource).disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
}
