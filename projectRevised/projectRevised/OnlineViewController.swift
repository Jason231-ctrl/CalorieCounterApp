//
//  OnlineViewController.swift
//  projectRevised
//
//  Created by Jason Leong on 11/14/21.
//

import UIKit

class OnlineViewController: UIViewController {

    var selected:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let scheme = "https"
        let host = "www.google.com"
        let path = "/search"
        let queryItem = URLQueryItem(name: "q", value: selected)
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = [queryItem]
        UIApplication.shared.canOpenURL(urlComponent.url!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
