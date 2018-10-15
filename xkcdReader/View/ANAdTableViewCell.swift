//
//  ANAdTableViewCell.swift
//  xkcdReader
//
//  Created by Anurag Shubham on 11/10/18.
//  Copyright © 2018 Anurag Shubham. All rights reserved.
//

import UIKit
import AdsNativeSDK
class ANAdTableViewCell: UITableViewCell, ANAdRendering {

    @IBOutlet weak var sponsoredText: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var callToActionButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
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
        adObject?.loadSponsoredTag(into: sponsoredText)
        adObject?.loadImage(into: mainImageView)
        
    }
    
    class func size(withMaximumWidth maximumWidth: CGFloat) -> CGSize {
        return CGSize(width: maximumWidth, height: 230)
    }
    
    // You MUST implement this method if YourNativeAdCell uses a nib
    class func nibForAd() -> String? {
        return "ANAdTableViewCell"
    }

}
