//
//  FindVC.swift
//  Rafd
//
//  Created by eric on 3/20/19.
//  Copyright © 2019 eric. All rights reserved.
//

import UIKit
import Alamofire

class FindVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var findCityCombo: SWComboxView!
    @IBOutlet weak var findBloodCombo: SWComboxView!
    @IBOutlet weak var findGenderCombo: SWComboxView!
    @IBOutlet weak var findAgeTxt: UITextField!
    @IBOutlet weak var findBtn: UIButton!
    @IBOutlet weak var findBackBtn: UIButton!

    var cityIndex = 0
    var bloodIndex = 0
    var genderIndex = 0
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findAgeTxt.delegate = self
        findBtn.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCombox()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setupCombox() {
        findCityCombo.dataSource = self
        findCityCombo.delegate = self
        findCityCombo.showMaxCount = 4
        findCityCombo.defaultSelectedIndex = 1 //start from 0
        
        findBloodCombo.dataSource = self
        findBloodCombo.delegate = self
        findBloodCombo.showMaxCount = 4
        findBloodCombo.defaultSelectedIndex = 1 //start from 0
        
        findGenderCombo.dataSource = self
        findGenderCombo.delegate = self
        findGenderCombo.showMaxCount = 3
        findGenderCombo.defaultSelectedIndex = 1 //start from 0
    }
    
    @IBAction func goToFind(_ sender: UIButton) {
        let url: String = "http://dip.com.sa/rafdapi/index.php/donation/get"
        let age: String = findAgeTxt.text!
        let params : Parameters = ["bloodId": bloodIndex,
                                   "cityId": cityIndex,
                                   "gender": genderIndex,
                                   "age": age]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).validate().responseString { (response) in
            switch response.result {
            case .success:
                let string_data = response.description
                var results = [ResultModel]()
                var donationString = string_data.replacingOccurrences(of: "]", with: "") + ","
                while donationString.count > 0 {
                    if let startIdx = donationString.index(of: "{") {
                        let temp = String(donationString[donationString.index(after: startIdx)..<donationString.endIndex])
                        donationString = String(donationString[startIdx..<donationString.endIndex])
                        if let endIdx = temp.index(of: "}") {
                            let substr = String(temp[temp.startIndex..<endIdx])
                            let anArr = substr.components(separatedBy: ",")
                            let fnameArr = anArr[3].components(separatedBy: ":")
                            let lnameArr = anArr[4].components(separatedBy: ":")
                            let genderArr = anArr[5].components(separatedBy: ":")
                            let ageArr = anArr[6].components(separatedBy: ":")
                            let phoneArr = anArr[7].components(separatedBy: ":")
                            let cityArr = anArr[10].components(separatedBy: ":")
                            let bloodArr = anArr[11].components(separatedBy: ":")
                            donationString = donationString.replacingOccurrences(of: "{"+substr+"},", with: "")
                            var wI = NSMutableString( string: fnameArr[1] )
                            CFStringTransform( wI, nil, "Any-Hex/Java" as NSString, true )
                            var fName = wI as String
                            fName = fName.replacingOccurrences(of: "\"", with: "")
                            wI = NSMutableString( string: lnameArr[1] )
                            CFStringTransform( wI, nil, "Any-Hex/Java" as NSString, true )
                            var lName = wI as String
                            lName = lName.replacingOccurrences(of: "\"", with: "")
                            wI = NSMutableString( string: cityArr[1] )
                            CFStringTransform( wI, nil, "Any-Hex/Java" as NSString, true )
                            var cityName = wI as String
                            cityName = cityName.replacingOccurrences(of: "\"", with: "")
                            let gender = genderArr[1].replacingOccurrences(of: "\"", with: "")
                            let age = ageArr[1].replacingOccurrences(of: "\"", with: "")
                            let phone = phoneArr[1].replacingOccurrences(of: "\"", with: "")
                            let blood = bloodArr[1].replacingOccurrences(of: "\"", with: "")
                           
                            let aResult = ResultModel(firstName: fName, lastName: lName, phone: phone, gender: gender, bloodType: blood, age: age, city: cityName)
                            results.append(aResult)
                        }
                    } else {
                        break;
                    }
                }
                
                let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultVCID") as? ResultVC
                resultVC?.mResults.removeAll()
                resultVC?.mResults = results
                self.present(resultVC!, animated: true, completion: nil)
            case .failure(let error):
                print("failed to load citylist: \(error.localizedDescription)")
            }
        }
//        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).validate().responseJSON{ response in
//            switch response.result {
//                case .success:
//                    if response.result.value != nil {
//                        let json_data = response.result.value as! [[String: Any]]
//                        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultVCID") as? ResultVC
//                        resultVC?.jsonResult = json_data
//                        self.present(resultVC!, animated: true, completion: nil)
//                    }
//                case .failure(let error):
//                    print("failed to load citylist: \(error.localizedDescription)")
//            }
//        }
    }

    @IBAction func backToMain(_ sender: UIButton) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVCID") as? MainVC
        self.present(mainVC!, animated: true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == findAgeTxt {
            textField.resignFirstResponder()
//        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if findCityCombo.isOpen {
            findCityCombo.onAndOffSelection()
        }
        if findBloodCombo.isOpen {
            findBloodCombo.onAndOffSelection()
        }
        if findGenderCombo.isOpen {
            findGenderCombo.onAndOffSelection()
        }
        self.view.endEditing(true)
    }
}

extension FindVC: SWComboxViewDataSourcce {
    func comboBoxSeletionItems(combox: SWComboxView) -> [Any] {
        var result = [Any]()
        if (combox == findCityCombo) {
            result = appDel.findcityresults
        }
        else if (combox == findBloodCombo) {
            result = appDel.findbloodresults
        } else {
            result = ["الكل", "ذكر", "أنثى"]
        }
        return result
    }
    
    func comboxSeletionView(combox: SWComboxView) -> SWComboxSelectionView {
            return SWComboxTextSelection()
    }
    
    func configureComboxCell(combox: SWComboxView, cell: inout SWComboxSelectionCell) {
            cell.selectionStyle = .none
    }
}

extension FindVC : SWComboxViewDelegate {
    //MARK: delegate
    func comboxSelected(atIndex index:Int, object: Any, combox withCombox: SWComboxView) {
        if withCombox == findCityCombo {
            cityIndex = index
        }
        if withCombox == findBloodCombo {
            bloodIndex = index
        }
        if withCombox == findGenderCombo {
            genderIndex = index
        }
    }
    
    func comboxOpened(isOpen: Bool, combox: SWComboxView) {
        if isOpen {
            if combox == findCityCombo {
                if findBloodCombo.isOpen {
                    findBloodCombo.onAndOffSelection()
                } else if findGenderCombo.isOpen {
                    findGenderCombo.onAndOffSelection()
                }
            }
            else if combox == findBloodCombo {
                if findCityCombo.isOpen {
                    findCityCombo.onAndOffSelection()
                } else if findGenderCombo.isOpen {
                    findGenderCombo.onAndOffSelection()
                }
            }
            else {
                if findCityCombo.isOpen {
                    findCityCombo.onAndOffSelection()
                } else if findBloodCombo.isOpen {
                    findBloodCombo.onAndOffSelection()
                }
            }
        }
    }
}

//extension FindVC: UITextFieldDelegate {
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        return true
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == findAgeTxt {
//            textField.resignFirstResponder()
////            self.view.endEditing(true)
//        }
//        return true
//    }
//}
