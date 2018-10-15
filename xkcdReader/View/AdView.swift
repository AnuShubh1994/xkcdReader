//
//  AdView.swift
//  xkcdReader
//
//  Created by Anurag Shubham on 11/10/18.
//  Copyright © 2018 Anurag Shubham. All rights reserved.
//

import UIKit

class AdView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var dimView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    var mediaView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    var titleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sponsoredText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var summary: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imgView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bell.png")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var skipButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupUI()
    }
    
    func setupUI() {
        addSubview(dimView)
        dimView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        dimView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        dimView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        dimView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        //        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        dimView.addSubview(imgView)
        dimView.addSubview(skipButton)
        dimView.addSubview(titleLabel)
        dimView.addSubview(subtitle)
        dimView.addSubview(summary)
        dimView.addSubview(sponsoredText)
        dimView.addSubview(mediaView)
        
        imgView.leadingAnchor.constraint(equalTo: dimView.leadingAnchor, constant: 8).isActive = true
        imgView.topAnchor.constraint(equalTo: dimView.topAnchor, constant: 8).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: dimView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        sponsoredText.bottomAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        sponsoredText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        sponsoredText.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: 8).isActive = true
        sponsoredText.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        mediaView.leadingAnchor.constraint(equalTo: dimView.leadingAnchor, constant: 8).isActive = true
        mediaView.trailingAnchor.constraint(equalTo: dimView.trailingAnchor, constant: -8).isActive = true
        mediaView.topAnchor.constraint(equalTo: dimView.bottomAnchor, constant: 8).isActive = true
        mediaView.heightAnchor.constraint(equalToConstant: 118).isActive = true
        
        summary.bottomAnchor.constraint(equalTo: dimView.bottomAnchor, constant: 8).isActive = true
        summary.leadingAnchor.constraint(equalTo: dimView.leadingAnchor, constant: 8).isActive = true
        
        skipButton.bottomAnchor.constraint(equalTo: dimView.bottomAnchor, constant: 8).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: dimView.trailingAnchor, constant: -8).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
