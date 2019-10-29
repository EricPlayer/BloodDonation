//
//  DonateVC.swift
//  Rafd
//
//  Created by eric on 3/20/19.
//  Copyright © 2019 eric. All rights reserved.
//

import UIKit
import Alamofire

class DonateVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var donateCityCombo: SWComboxView!
    @IBOutlet weak var donateBloodCombo: SWComboxView!
    @IBOutlet weak var donateGenderCombo: SWComboxView!
    @IBOutlet weak var donateBackBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var yearTxt: UITextField!
    @IBOutlet weak var monthTxt: UITextField!
    @IBOutlet weak var dayTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var inView: UIView!
    
    var cityIndex = 0
    var bloodIndex = 0
    var genderIndex = 0
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var scrollViewY = 0.0 as CGFloat
    var screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTxt.delegate = self
        lastNameTxt.delegate = self
        yearTxt.delegate = self
        monthTxt.delegate = self
        dayTxt.delegate = self
        phoneTxt.delegate = self
        submitBtn.layer.borderColor = UIColor.black.cgColor
        scrollViewY = scrollView.frame.origin.y
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCombox()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVCID") as? MainVC
        self.present(mainVC!, animated: true, completion: nil)
    }
    
    @IBAction func goToSubmit(_ sender: UIButton) {
        self.validationCheck()
    }
    
    func setupCombox() {
        donateCityCombo.dataSource = self
        donateCityCombo.delegate = self
        donateCityCombo.showMaxCount = 4
        donateCityCombo.defaultSelectedIndex = 1 //start from 0

        donateBloodCombo.dataSource = self
        donateBloodCombo.delegate = self
        donateBloodCombo.showMaxCount = 4
        donateBloodCombo.defaultSelectedIndex = 1 //start from 0

        donateGenderCombo.dataSource = self
        donateGenderCombo.delegate = self
        donateGenderCombo.showMaxCount = 3
        donateGenderCombo.defaultSelectedIndex = 1 //start from 0
    }
    
    func validationCheck() {
        if( firstNameTxt.text == "" ) {
            firstNameTxt.layer.borderColor = UIColor.red.cgColor
            firstNameTxt.layer.borderWidth = 1
            return
        } else {
            firstNameTxt.layer.borderWidth = 0
        }
        if( lastNameTxt.text == "" ) {
            lastNameTxt.layer.borderColor = UIColor.red.cgColor
            lastNameTxt.layer.borderWidth = 1
            return
        } else {
            lastNameTxt.layer.borderWidth = 0
        }// i think because it should use English numbers    look
        if( yearTxt.text == "" || Int(yearTxt.text!)! < 1900 ) {
            yearTxt.layer.borderColor = UIColor.red.cgColor
            yearTxt.layer.borderWidth = 1
            return
        } else {
            yearTxt.layer.borderWidth = 0
        }
        if( monthTxt.text == "" || Int(monthTxt.text!)! > 12 || (monthTxt.text?.count)! < 2 ) {
            monthTxt.layer.borderColor = UIColor.red.cgColor
            monthTxt.layer.borderWidth = 1
            return
        } else {
            monthTxt.layer.borderWidth = 0
        }
        if( dayTxt.text == "" || Int(dayTxt.text!)! > 31  || (dayTxt.text?.count)! < 2 ) {
            dayTxt.layer.borderColor = UIColor.red.cgColor
            dayTxt.layer.borderWidth = 1
            return
        } else {
            dayTxt.layer.borderWidth = 0
        }
        if( cityIndex == 0 ) {
            donateCityCombo.layer.borderColor = UIColor.red.cgColor
            donateCityCombo.layer.borderWidth = 1
            return
        } else {
            donateCityCombo.layer.borderWidth = 0
        }
        if( bloodIndex == 0 ) {
            donateBloodCombo.layer.borderColor = UIColor.red.cgColor
            donateBloodCombo.layer.borderWidth = 1
            return
        } else {
            donateBloodCombo.layer.borderWidth = 0
        }
        if( genderIndex == 0 ) {
            donateGenderCombo.layer.borderColor = UIColor.red.cgColor
            donateGenderCombo.layer.borderWidth = 1
            return
        } else {
            donateGenderCombo.layer.borderWidth = 0
        }
        if( phoneTxt.text == "" ) {
            phoneTxt.layer.borderColor = UIColor.red.cgColor
            phoneTxt.layer.borderWidth = 1
            return
        } else {
            phoneTxt.layer.borderWidth = 0
        }
        self.doSubmitDonation()
    }
    
    func doSubmitDonation() {
        let url: String = "http://dip.com.sa/rafdapi/index.php/donation/add"
        let firstName: String = firstNameTxt.text!
        let lastName: String = lastNameTxt.text!
        let year: String = yearTxt.text!
        let month: String = monthTxt.text!
        let day: String = dayTxt.text!
        let phone: String = phoneTxt.text!
        let params : Parameters = ["firstName": firstName,
                                   "lastName": lastName,
                                   "birth": year+"-"+month+"-"+day,
                                   "bloodId": bloodIndex,
                                   "cityId": cityIndex,
                                   "gender": genderIndex,
                                   "phone": phone]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).validate().responseString{ (response) in
            switch response.result {
                case .success:
                    let string_data = response.description
                    print(string_data);
                    let anArr = string_data.components(separatedBy: ":")
                    let resultStr = anArr[2].replacingOccurrences(of: "}", with: "")
                    if resultStr == "true" {
                        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVCID") as? MainVC
                        self.present(mainVC!, animated: true, completion: nil)
                    }
                case .failure(let error):
                    print("failed to load citylist: \(error.localizedDescription)")
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxlength = 30
        if textField == yearTxt {
            maxlength = 4
        }
        else if textField == monthTxt || textField == dayTxt {
            maxlength = 2
        }
        let currentString:NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length == maxlength + 1 {
            if textField == yearTxt {
                monthTxt.becomeFirstResponder()
            }
            else if textField == monthTxt {
                dayTxt.becomeFirstResponder()
            }
            else if textField == dayTxt {
                phoneTxt.becomeFirstResponder()
            }
        }
        return newString.length <= maxlength
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //let modelName = UIDevice().model
        if textField == firstNameTxt {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY), animated: true)
        }
        else if textField == lastNameTxt {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY + 20.0), animated: true)
        }
        else if textField == yearTxt || textField == monthTxt || textField == dayTxt {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY + 25.0 * 2), animated: true)
        }
        else if textField == phoneTxt {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY + 25.0 * 3), animated: true)
        }
        else {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY), animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTxt {
            lastNameTxt.becomeFirstResponder()
        }
        if textField == lastNameTxt {
            yearTxt.becomeFirstResponder()
        }
        if textField == yearTxt {
            monthTxt.becomeFirstResponder()
        }
        if textField == monthTxt {
            dayTxt.becomeFirstResponder()
        }
        if textField == dayTxt {
            phoneTxt.becomeFirstResponder()
        }
        if textField == phoneTxt {
            self.view.endEditing(true)
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// SWComboxViewDataSourcce
extension DonateVC: SWComboxViewDataSourcce {
    func comboxSeletionView(combox: SWComboxView) -> SWComboxSelectionView {
        return SWComboxTextSelection()
    }

    func comboBoxSeletionItems(combox: SWComboxView) -> [Any] {
        var result = [Any]()
        if combox == donateCityCombo {
            result = appDel.donatecityresults
        } else if combox == donateBloodCombo {
            result = appDel.donatebloodresults
        } else {
            result = ["الجنس", "ذكر", "أنثى"]
        }
        return result
    }

    func configureComboxCell(combox: SWComboxView, cell: inout SWComboxSelectionCell) {
        cell.selectionStyle = .none
    }
}

// SWComboxViewDelegate
extension DonateVC : SWComboxViewDelegate {
    func comboxSelected(atIndex index:Int, object: Any, combox withCombox: SWComboxView) {
        if withCombox == donateCityCombo {
            cityIndex = index
        }
        if withCombox == donateBloodCombo {
            bloodIndex = index
        }
        if withCombox == donateGenderCombo {
            genderIndex = index
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY), animated: true)
        }
    }

    func comboxOpened(isOpen: Bool, combox: SWComboxView) {
        if isOpen {
            if combox == donateCityCombo {
                if donateBloodCombo.isOpen {
                    donateBloodCombo.onAndOffSelection()
                } else if donateGenderCombo.isOpen {
                    donateGenderCombo.onAndOffSelection()
                }
                scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY + 25.0 * 4), animated: true)
            }
            else if combox == donateBloodCombo {
                if donateCityCombo.isOpen {
                    donateCityCombo.onAndOffSelection()
                } else if donateGenderCombo.isOpen {
                    donateGenderCombo.onAndOffSelection()
                }
                scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY + 25.0 * 5), animated: true)
            }
            else {
                if donateCityCombo.isOpen {
                    donateCityCombo.onAndOffSelection()
                } else if donateBloodCombo.isOpen {
                    donateBloodCombo.onAndOffSelection()
                }
                scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY + 25.0 * 6), animated: true)
            }
            self.view.endEditing(true)
        }
    }
}

//extension DonateVC : UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        var maxlength = 30
//        if textField == yearTxt {
//            maxlength = 4
//        }
//        else if textField == monthTxt || textField == dayTxt {
//            maxlength = 2
//        }
//        let currentString:NSString = textField.text! as NSString
//        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//        return newString.length <= maxlength
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        //let modelName = UIDevice().model
//        if textField == firstNameTxt {
//            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY), animated: true)
//        }
//        else if textField == lastNameTxt {
//            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY + 20.0), animated: true)
//        }
//        else if textField == yearTxt || textField == monthTxt || textField == dayTxt {
//            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY + 25.0 * 2), animated: true)
//        }
//        else if textField == phoneTxt {
//            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY + 25.0 * 3), animated: true)
//        }
//        else {
//            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewY), animated: true)
//        }
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////        if textField == firstNameTxt {
////            lastNameTxt.becomeFirstResponder()
////        }
////        if textField == lastNameTxt {
////            yearTxt.becomeFirstResponder()
////        }
////        if textField == yearTxt {
////            monthTxt.becomeFirstResponder()
////        }
////        if textField == monthTxt {
////            dayTxt.becomeFirstResponder()
////        }
////        if textField == dayTxt {
////            phoneTxt.becomeFirstResponder()
////        }
////        if textField == phoneTxt {
////            self.view.endEditing(true)
////        }
////        else {
////            textField.resignFirstResponder()
////        }
//        textField.resignFirstResponder()
//        return true
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//}

