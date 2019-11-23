//
//  ListTableViewCell.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import UIKit

protocol ProductCellDelegate {
    func numberOfProductsSelected(cell: ListTableViewCell, number : Int)
}

class ListTableViewCell : UITableViewCell {
    var delegate : ProductCellDelegate?
    let minValue = 0
    
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
    
    private let decreaseButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "minusTb"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    private let increaseButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "addTb"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    var productQuantity : UILabel =  {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "0"
        label.textColor = .black
        return label
    }()
    
    @objc func decreaseFunc() {
        changeQuantity(by: -1)
    }
    
    @objc func increaseFunc() {
        changeQuantity(by: 1)
    }
    
    func changeQuantity(by amount: Int) {
        var quality = Int(productQuantity.text!)!
        quality += amount
        if quality < minValue {
            quality = 0
            productQuantity.text = "0"
        } else {
            productQuantity.text = "\(quality)"
        }
        delegate?.numberOfProductsSelected(cell: self, number: quality)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productTitleLabel)
        addSubview(productCreatedAtLabel)
        addSubview(decreaseButton)
        addSubview(productQuantity)
        addSubview(increaseButton)
        
        productTitleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width*3/4, height: 0, enableInsets: false)
        productCreatedAtLabel.anchor(top: productTitleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width*3/4, height: 0, enableInsets: false)
        
        let stackView = UIStackView(arrangedSubviews: [decreaseButton,productQuantity,increaseButton])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: productTitleLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 10, width: 0, height: 70, enableInsets: false)
        
        increaseButton.addTarget(self, action: #selector(increaseFunc), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decreaseFunc), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
