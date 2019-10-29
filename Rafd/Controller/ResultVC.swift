//
//  ResultVC.swift
//  Rafd
//
//  Created by eric on 3/20/19.
//  Copyright © 2019 eric. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var donationTV: UITableView!
    
    var mResults = [ResultModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donationTV.reloadData()
    }
    
    @IBAction func backToFind(_ sender: UIButton) {
        let findVC = self.storyboard?.instantiateViewController(withIdentifier: "FindVCID") as? FindVC
        self.present(findVC!, animated: true, completion: nil)
    }
}

extension ResultVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = mResults.count
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTVCellID") as! ResultTVCell
        let fName : String = mResults[indexPath.row].getFirstName()
        let lName : String = mResults[indexPath.row].getLastName()
        cell.nameLbl.text = fName+" "+lName
        let gender : String = (Int(mResults[indexPath.row].getGender())! == 1) ? "ذكر" : "أنثى"
        cell.phoneLbl.text = mResults[indexPath.row].getPhone()
        cell.genderLbl.text = gender
        cell.bloodLbl.text = mResults[indexPath.row].getBloodType()
        cell.ageLbl.text = mResults[indexPath.row].getAge()
        cell.cityLbl.text = mResults[indexPath.row].getCity()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func onClickPhone(_ sender: UIButton) {
//        self.curResultIdx = sender.tag
//        performSegue(withIdentifier: "PhoneClickSegue", sender: nil)
    }

}
