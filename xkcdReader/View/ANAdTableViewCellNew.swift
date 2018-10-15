//
//  ANAdTableViewCellNew.swift
//  xkcdReader
//
//  Created by Anurag Shubham on 15/10/18.
//  Copyright © 2018 Anurag Shubham. All rights reserved.
//

import UIKit
import AdsNativeSDK
class ANAdTableViewCellNew: UITableViewCell, ANAdRendering {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainTextLabel: UILabel!
    @IBOutlet var callToActionButton: UIButton!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    
    
    class func size(withMaximumWidth maximumWidth: CGFloat) -> CGSize {
        return CGSize(width: maximumWidth, height: 78)
    }
    
    // You MUST implement this method if YourNativeAdCell uses a nib
    class func nibForAd() -> String? {
        return "ANAdTableViewCellNew"
    }
    
    override func awakeFromNib() {
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func layoutAdAssets(_ adObject: PMNativeAd?) {
        adObject?.loadTitle(into: titleLabel)
        adObject?.loadText(into: mainTextLabel)
        adObject?.loadCallToActionText(into: callToActionButton)
        adObject?.loadIcon(into: iconImageView)
    }
}
