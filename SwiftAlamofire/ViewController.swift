//
//  ViewController.swift
//  SwiftAlamofire
//
//  Created by MMizogaki on 10/14/15.
//  Copyright © 2015 [MMasahito](https://github.com/MMasahito). All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftTask

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        /**  GET Json */
        let jsonUrl:String! = "http://www.raywenderlich.com/demos/weather_sample/weather.php"
        Alamofire.request(.GET,jsonUrl, parameters:["format" : "json"])
            .validate(statusCode: 200..<400)
            .response { (_, _, _, error) in
                print(error)
            }
            .response { (request, response, data, error) in
                print(request)
                print(response)
                print(error)
        }
        
        /** Download png */
        let downloadUrl:String! = "http://ryoyakawai.github.io/gtuggirls-webaudio/images/github.png"
        Alamofire.download(.GET, downloadUrl) { temporaryURL, response in
            let URLs = NSFileManager.defaultManager()
                .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            
            if URLs.count > 0 {
                let documentURL = URLs[0] as NSURL
                print("OK")
                return documentURL.URLByAppendingPathComponent(response.suggestedFilename!)
                
            } else {
                return temporaryURL
            }
        }
        
        /** Download Progress */
        let progressUrl:String! = "http://www.noao.edu/image_gallery/images/d7/cygloop.jpg"
        Alamofire.request(.GET,  progressUrl)
            .validate(statusCode: 200..<400)
            .response { (_, _, _, error) in
                print(error)
            }
            .progress { bytes, totalBytes, totalBytesExpected in
                print("Download bytes: \(bytes), totalBytes: \(totalBytes)")
        }
        
        /** Basic authentication */
        let identifier = "yourname"
        let password = "yourpassword"
        Alamofire.request(.GET, "https://localhost.jp/basic-auth/")
            .authenticate(user: identifier, password: password)
            .response {(request, response, _, error) in
                print(response)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
