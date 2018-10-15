//
//  ViewController.swift
//  xkcdReader
//
//  Created by Anurag Shubham on 11/10/18.
//  Copyright © 2018 Anurag Shubham. All rights reserved.
//

import UIKit
import Kingfisher
import AdsNativeSDK
class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,PMClassDelegate  {
    func pmViewControllerForPresentingModalView() -> UIViewController! {
        return self
    }
    
    
    let cellIdentifier = "ImageCell"
    let listCellIdentifier = "ListCell"
    
    var isListView = true
    
    let defaults = UserDefaults.standard
    
    var toggleButton = UIBarButtonItem()
    
    var comicArray = Array<Any>()
    
    var pmClass: PMClass?
    
//    lazy var refreshControl: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action:
//            #selector(self.handleRefresh(_:)),
//                                 for: UIControlEvents.valueChanged)
//        refreshControl.tintColor = UIColor.blue
//
//        return refreshControl
//    }()
    
    var counter = 11
    
    var adCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //defaults.set(0, forKey: "adCounter")
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.register(ListCell.self, forCellWithReuseIdentifier: listCellIdentifier)
        
        toggleButton = UIBarButtonItem(title: "Grid", style: .plain, target: self, action: #selector(buttonTapped(sender:)))
        self.navigationItem.setRightBarButton(toggleButton, animated: true)
        getData()
        
//        LogSetLevel(LogLevelDebug)
//        pmClass = PMClass(adUnitID: "2Pwo1otj1C5T8y6Uuz9v-xbY1aB09x8rWKvsJ-HI", requestType: PM_REQUEST_TYPE(PM_REQUEST_TYPE_NATIVE), withBannerSize: CGSize(width: 0, height: 0))
//        //self.pmClass = [[PMClass alloc] initWithAdUnitID:@"ping" requestType:PM_REQUEST_TYPE_NATIVE withBannerSize:CGSizeMake(0, 0)];
//
//        //For banner requests
//        //  self.pmClass  = [[PMClass alloc] initWithAdUnitID:@"pUW7n6VJQesm68GmdYyDA4IZhNzjm8CC3KrDVzLU" requestType:PM_REQUEST_TYPE_BANNER withBannerSize:self.adViewContainer.bounds.size];
//
//        pmClass?.delegate = self
    }
    
    func getData() {
        comicArray.removeAll()
//        DispatchQueue.main.async {
//            if self.counter == 1 {
//                for i in 1..<11 {
//                    self.serverCall(i: i)
//                }
//                self.counter += 10
//            }else {
//                let j = self.counter
//                self.counter += 10
//                for i in j..<self.counter {
//                    self.serverCall(i: i)
//                }
//            }
//            self.collectionView?.reloadData()
//        }
        DispatchQueue.main.async {
            for i in 1..<self.counter {
                self.serverCall(i: i)
            }
            self.counter += 10
            self.collectionView?.reloadData()
        }
        
    }
    
    func serverCall(i: Int) {
        RequestModule.comicList(id: i) { (success, data, errorMsg, response) in
            if success {
                if let dict = ParsingData.parseJsonFrom(data: data!) {
                    print(dict)
                    self.comicArray.append(dict)
                    print("count: \(self.comicArray.count)")
                        self.collectionView?.reloadData()
                }else {
                    if let responseCode = (response as? HTTPURLResponse)?.statusCode, responseCode == 401 || responseCode == 403 {
                        //print("No Authorization \(errorMsg)")
                    }else {
                        //print(errorMsg)
                    }
                }
            }
            
        }
    }
    
    @objc func buttonTapped(sender: UIBarButtonItem) {
        if isListView {
            toggleButton = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(buttonTapped(sender:)))
            isListView = false
        }else {
            toggleButton = UIBarButtonItem(title: "Grid", style: .plain, target: self, action: #selector(buttonTapped(sender:)))
            isListView = true
        }
        
        self.navigationItem.setRightBarButton(toggleButton, animated: true)
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var dict = [String:Any]()
        dict = (comicArray[indexPath.item] as? [String:Any])!
        let imageName = dict["img"] as? String
        if isListView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellIdentifier, for: indexPath) as! ListCell
            
            cell.titleLabel.text = dict["title"] as? String
            cell.descriptionLabel.text = dict["alt"] as? String
            
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
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCell
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
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        if isListView {
            return CGSize(width: width, height: 120)
        }else {
            return CGSize(width: (width - 15)/2, height: (width - 15)/2)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if defaults.value(forKey: "adCounter") != nil {
            adCounter = defaults.integer(forKey: "adCounter")
            adCounter += 1
            defaults.set(adCounter, forKey: "adCounter")
        }else {
            adCounter += 1
            defaults.set(adCounter, forKey: "adCounter")
        }
        var dict = [String:Any]()
        dict = (comicArray[indexPath.item] as? [String:Any])!
        let vc = DetailVC()
        vc.dict = dict
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 0.0
//        vc.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        vc.collectionView.register(DetailCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == comicArray.count - 1 {
            print("the other end")
            DispatchQueue.main.async {
                for i in self.counter..<self.counter+10 {
                    self.serverCall(i: i)
                }
                self.counter += 10
                //self.collectionView?.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




