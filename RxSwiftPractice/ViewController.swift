//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by taichi on 2021/11/17.
//

import UIKit
import RxSwift
import RxCocoa


struct Product {
    let imageUrl:String
    let title:String
}

struct ProductViewModel {
    var items = PublishSubject<[Product]>()
    
    func fetchItems(){
        let products = [
        Product(imageUrl: "house", title: "Home"),
        Product(imageUrl: "gear", title: "Setting"),
        Product(imageUrl: "person.circle", title: "Profile"),
        Product(imageUrl: "airplane", title: "Fights"),
        Product(imageUrl: "bell", title: "Activity")
        ]
        
        items.onNext(products)
        items.onCompleted()
    }
    
}





class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var viewModel = ProductViewModel()
    
    private var bag = DisposeBag()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindTableData()
        
    
    }
    
    
    
    
    
    func bindTableData() {
        
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, model, cell in
            cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imageUrl)
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Product.self).bind { product in
            print(product.title)
        }.disposed(by: bag)
        
        viewModel.fetchItems()
    }
    
    
    
    
    
    
    
    


}

