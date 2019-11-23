//
//  ListDetailViewController.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 23/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import UIKit

protocol ListDetailViewPrototocol: class {
    var presenter: ListDetailViewPresenterProtocol? { get set }
    func showPostDetail(forPost post: Hits)
}

class ListDetailViewController: UIViewController {

    var presenter: ListDetailViewPresenterProtocol?
    
    let mainView = UIView()
    
    var post: Hits? {
        didSet {
            productTitleLabel.text = post?.title
            productCreatedAtLabel.text = post?.created_At
        }
    }
    
    private let productTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let productCreatedAtLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupMainView()
    }
    
    func setupMainView() {
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension ListDetailViewController: ListDetailViewPrototocol {
    
    func showPostDetail(forPost post: Hits) {
        self.post = post
        mainView.addSubview(productTitleLabel)
        mainView.addSubview(productCreatedAtLabel)
    }
}
