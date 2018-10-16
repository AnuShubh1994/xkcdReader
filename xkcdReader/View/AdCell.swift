//
//  AdCell.swift
//  xkcdReader
//
//  Created by Anurag Shubham on 16/10/18.
//  Copyright © 2018 Anurag Shubham. All rights reserved.
//

import UIKit
import AdsNativeSDK
class AdCell: UICollectionViewCell, ANAdRendering {
    
    //var adObject: PMNativeAd?
    
    class func size(withMaximumWidth maximumWidth: CGFloat) -> CGSize {
        return CGSize(width: maximumWidth, height: 230)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = UIColor.white
        addSubview(dimView)
        dimView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        dimView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        dimView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        dimView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        dimView.addSubview(iconImageView)
        dimView.addSubview(skipButton)
        dimView.addSubview(titleLabel)
        dimView.addSubview(subtitle)
        dimView.addSubview(summary)
        dimView.addSubview(sponsoredText)
        dimView.addSubview(mainImageView)
//        imgView.heightAnchor.constraint(equalToConstant: 80).isActive = true
//        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        
        iconImageView.leadingAnchor.constraint(equalTo: dimView.leadingAnchor, constant: 8).isActive = true
        iconImageView.topAnchor.constraint(equalTo: dimView.topAnchor, constant: 8).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: dimView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: dimView.trailingAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        //sponsoredText.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor).isActive = true
        sponsoredText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        sponsoredText.trailingAnchor.constraint(equalTo: dimView.trailingAnchor, constant: -8).isActive = true
        sponsoredText.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        sponsoredText.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        mainImageView.leadingAnchor.constraint(equalTo: dimView.leadingAnchor, constant: 8).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: dimView.trailingAnchor, constant: -8).isActive = true
        mainImageView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 118).isActive = true
        
        summary.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8).isActive = true
        summary.leadingAnchor.constraint(equalTo: dimView.leadingAnchor, constant: 8).isActive = true
        
        skipButton.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: dimView.trailingAnchor, constant: -8).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func layoutAdAssets(_ adObject: PMNativeAd?) {
        adObject?.loadTitle(into: titleLabel)
        adObject?.loadText(into: summary)
        adObject?.loadCallToActionText(into: skipButton)
        adObject?.loadIcon(into: iconImageView)
        adObject?.loadSponsoredTag(into: sponsoredText)
        adObject?.loadImage(into: mainImageView)
//        adObject?.loadImage(into: imgView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "bell.png")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var dimView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var mainImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bell.png")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    var skipButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
}
