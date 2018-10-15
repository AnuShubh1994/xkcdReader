//
//  DetailVC.swift
//  xkcdReader
//
//  Created by Anurag Shubham on 11/10/18.
//  Copyright © 2018 Anurag Shubham. All rights reserved.
//

import UIKit
import Kingfisher
import AdsNativeSDK
class DetailVC: UIViewController,ANTableViewAdPlacerDelegate {

    var safeLayout = UILayoutGuide()
    
    var tableView:UITableView!
    
    var dict = [String:Any]()
    
    var hidden = true
    
    var placer = ANTableViewAdPlacer()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if defaults.integer(forKey: "adCounter") >= 0 {
            let serverAdPositions = ANClientAdPositions()
            //The defaultRenderingClass can be switched to `ANAdTableViewCellNew` dynamically by specifying it in the AdsNative UI
            LogSetLevel(LogLevelDebug)
            placer = ANTableViewAdPlacer(tableView: tableView, viewController: self, adPositions: serverAdPositions, defaultAdRenderingClass: ANAdTableViewCell.self)
            placer.delegate = self
            placer.loadAds(forAdUnitID: "ping")
            //placer.loadAds(forAdUnitID: "2Pwo1otj1C5T8y6Uuz9v-xbY1aBO9x8rWKvsJ-HI")
            defaults.set(0, forKey: "adCounter")
        }

    }
    
    override func loadView() {
        super.loadView()
        if #available(iOS 11.0, *) {
            safeLayout = view.safeAreaLayoutGuide
        }
        setUpViews()
    }
    
    func setUpViews() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        //        if defaults.bool(forKey: "isiPhoneX"){
        //            tableView.topAnchor.constraint(equalTo: safeLayout.topAnchor, constant: -88).isActive = true
        //        }else {
        //            tableView.topAnchor.constraint(equalTo: safeLayout.topAnchor, constant: 0).isActive = true
        //        }
        
        if #available(iOS 11.0, *) {
            tableView.topAnchor.constraint(equalTo: safeLayout.topAnchor, constant: 0).isActive = true
            tableView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor).isActive = true
        }else {
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
        tableView.register(DetailCell.self, forCellReuseIdentifier: "cell")
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func anNativeAdDidRecordImpression() {
        print("Inside TableView Recorded Impression")
    }
    
    func anNativeAdDidClick(_ nativeAd: PMNativeAd!) -> Bool {
        print("Inside TableView Recorded Click")
        return false
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailCell
        let imageName = dict["img"] as? String
        let date = "\(dict["day"] as! String)/\(dict["month"] as! String)/\(dict["year"] as! String)"
        cell.title.text = "\((dict["title"] as? String)!) (\(date))"//.attributedText = RequestModule.getAttributedTextForTitle(first: (dict["title"] as? String)!, second: date)
        cell.subtitle.text = (dict["alt"] as? String)!
        cell.subtitle.isHidden = hidden
        if let profileImage = ImageCache.default.retrieveImageInDiskCache(forKey: imageName!) {
            cell.imgView.image = profileImage
        }else {
            // Data for "images/island.jpg" is returned
            //                        let image = UIImage(data: data!)
            //                        self.profileNavButton.setImage(image, for: .normal)
            let url = URL(string: imageName!)
            cell.imgView.kf.setImage(with: url)
            //                ImageCache.default.store(cell.imgView.image!, forKey: imageName!, toDisk: true)
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hide))
        cell.imgView.isUserInteractionEnabled = true
        cell.imgView.addGestureRecognizer(tap)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height - UIApplication.shared.statusBarFrame.height
    }
    
    
    @objc func hide() {
        hidden = !hidden
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DetailCell
        cell?.subtitle.isHidden = hidden
    }
    
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        //print(textField.text! + string)
    //        phoneNumber = textField.text! + string
    //        return true
    //    }
    
    

}
