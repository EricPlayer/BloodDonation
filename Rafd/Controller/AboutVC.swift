//
//  AboutVC.swift
//  Rafd
//
//  Created by eric on 3/26/19.
//  Copyright © 2019 eric. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var aboutBackBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onBackToMain(_ sender: UIButton) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVCID") as? MainVC
        self.present(mainVC!, animated: true, completion: nil)
    }
}
