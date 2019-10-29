//
//  MainVC.swift
//  Rafd
//
//  Created by eric on 3/20/19.
//  Copyright © 2019 eric. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var donateBtn: UIButton!
    @IBOutlet weak var findBtn: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    
    @IBOutlet weak var combo1: SWComboxView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        donateBtn.layer.borderColor = UIColor.black.cgColor
        findBtn.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func onDonate(_ sender: UIButton) {
        let donateVC = self.storyboard?.instantiateViewController(withIdentifier: "DonateVCID") as? DonateVC
        self.present(donateVC!, animated: true, completion: nil)
    }
    
    @IBAction func onFind(_ sender: UIButton) {
        let findVC = self.storyboard?.instantiateViewController(withIdentifier: "FindVCID") as? FindVC
        self.present(findVC!, animated: true, completion: nil)
    }
    
    @IBAction func onAbout(_ sender: UIButton) {
        let aboutVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutVCID") as? AboutVC
        self.present(aboutVC!, animated: true, completion: nil)
    }
}
