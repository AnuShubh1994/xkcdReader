//
//  UrlModule.swift
//  xkcdReader
//
//  Created by Anurag Shubham on 11/10/18.
//  Copyright © 2018 Anurag Shubham. All rights reserved.
//

import UIKit
import Foundation
class UrlModule: NSObject {

    class func getUrl(id: Int) -> String {
        return String(format: "https://xkcd.com/%d/info.0.json", id) as String
    }
    
}
class RequestModule: NSObject {
    
    typealias CompletionHandler = (_ success: Bool, _ data: Data?, _ error_message: String?, _ response: URLResponse?) -> Void
    
    class func comicList(id: Int, completion: @escaping CompletionHandler) {
        
        let url = UrlModule.getUrl(id: id)
        
        var request = URLRequest.init(url: URL(string: url as String)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        
        request.httpMethod = "GET"
        //print(dict)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.addValue(UserDefaults.standard.string(forKey: "localTimeZoneName")!, forHTTPHeaderField: "CLIENTTZ")
//        request.addValue(UserDefaults.standard.string(forKey: "auth_token")!, forHTTPHeaderField: "Authorization")
        //Get cache response using request object
        
        //default configuration
        let config = URLSessionConfiguration.default
        
        //create session with configration
        let session = URLSession.init(configuration: config, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if data != nil {
                    let responseCode = (response as! HTTPURLResponse).statusCode
                    if responseCode == 200 {
                        completion(true, data, nil, response)
                    }else {
                        if let dict = ParsingData.parseJsonFrom(data: data!) {
                            completion(false, data, dict["status_message"] as? String, response)
                        }
                    }
                }
                else {
                    completion(false, nil, error?.localizedDescription, nil)
                }
            }
        })
        task.resume()
    }
    
    class func getAttributedTextForTitle(first: String, second: String) -> NSMutableAttributedString {
        var normalString = ""
        if first != "" {
            normalString = "\(first)\n\(second)"
        }else {
            normalString = "\(second)"
        }
        
        let attributedText = NSMutableAttributedString(string: normalString)
        if first != "" {
            attributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], range: NSRange.init(location: 0, length: first.count))
        }
        
        if second != "" {
            attributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], range: NSRange.init(location: first == "" ? 0 : first.count + 1, length: second.count))
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedText.length))
        
        return attributedText
    }
    
}
class ParsingData {
    
    class func parseJsonFrom(data: Data) -> [String: Any]? {
        do {
            let JSON = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            return JSON
        } catch {
            //print(error.localizedDescription)
        }
        return nil
    }
}
