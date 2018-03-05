//
//  ViewController.swift
//  daily-dose
//
//  Created by david.roff on 2/15/18.
//  Copyright © 2018 david.roff. All rights reserved.
//

typealias  CompletionHandler = (_ success: Bool) -> ()

import UIKit
import GoogleMobileAds

class HomeVC: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var removeAdsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAds() {
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS) {
            removeAdsButton.removeFromSuperview()
            bannerView.removeFromSuperview()
        } else {
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
    }

    @IBAction func removeAdsPressed(_ sender: Any) {
        PurchaseManager.instance.purchaseRemoveAds { success in
            if success {
                self.bannerView.removeFromSuperview()
                self.removeAdsButton.removeFromSuperview()
            } else {
                //show message to user
            }
        }
    }
    
    @IBAction func restoreBtnPressed(_ sender: Any) {
        PurchaseManager.instance.restorePurchases { success in
            if success {
                self.setupAds()
            }
        }
    }
    
}

