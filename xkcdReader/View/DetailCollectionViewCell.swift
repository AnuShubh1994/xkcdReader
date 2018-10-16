//
//  DetailCollectionViewCell.swift
//  xkcdReader
//
//  Created by Anurag Shubham on 16/10/18.
//  Copyright © 2018 Anurag Shubham. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        backgroundColor = UIColor.white
        
        addSubview(title)
        addSubview(subtitle)
        addSubview(imgView)
        
        //        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        //        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        imgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        //        imgView.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        //        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        title.bottomAnchor.constraint(equalTo: imgView.topAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.textAlignment = .center
        title.numberOfLines = 0
        title.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        
        subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        subtitle.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        subtitle.numberOfLines = 0
        subtitle.isHidden = true
        
        title.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imgView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bell.png")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.borderColor = UIColor.black.cgColor
        imgView.layer.borderWidth = 1.0
    }
    
}
