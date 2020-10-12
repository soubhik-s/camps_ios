//
//  ApplicatonFormVC1.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 11/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ApplicatonFormVC1: UIViewController {
    
    @IBOutlet weak var packageLbl: UILabel!
    
    
    @IBOutlet weak var ageGroupLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var seasonTF: UITextField!
    
    
    @IBOutlet weak var sibling_LName_TF: UITextField!
    @IBOutlet weak var sibling_FName_TF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var batchTF: UITextField!
    
    @IBOutlet weak var mobileTF: UITextField!
   
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var motherTongueTF: UITextField!
    @IBOutlet weak var TshirtTF: UITextField!
    @IBOutlet weak var citizenShipTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    
    @IBOutlet weak var weightTF: UITextField!
    
    @IBOutlet weak var DOBTF: UITextField!
    
    let picker = UIPickerView()
   
    let springCamp = [""]
    let summerCamp = [""]
    let autumnCamp = [""]
    let pre_winterCamp = [""]
    let winterCamp = [""]

    let childBatch = ["Batch-I"]
    let adultBatch = ["Batch-II"]

    let TShirt_Arr = ["S","M","L","XL","XXL"]
    
    @IBOutlet weak var sibling_SV: UIStackView!
    
    @IBOutlet weak var sibling_SC: UISegmentedControl!
    var isSibling:Bool = false
   
    @IBOutlet weak var sibling_MobileTF: UITextField!
    
    @IBOutlet weak var sibling_EmailTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
       
    }
    
    func viewChanges() {
        
        headerView.layer.cornerRadius = 10
        nextBtn.makeRound()
        packageLbl.text = BookingDetails.package_name
        priceLbl.text = BookingDetails.price
        ageGroupLbl.text = BookingDetails.age_Group
        picker.backgroundColor = .lightColor
        picker.tintColor = .baseColor
        picker.delegate = self
        picker.dataSource = self
        firstNameTF.text = UserDetails.firstName
        lastNameTF.text = UserDetails.lastName
        mobileTF.text = UserDetails.mobileNumber
        emailTF.text = UserDetails.email
        sibling_SV.isHidden = true
        
        
    }
    
    
    
    func seasonActivity() {
        let day = getCurrentday()
        let currentMonth = getCurrentMonth()
        let cureentYear = getCurrentYear()
      
        if BookingDetails.package_id < 6 {
            if currentMonth < 5 {
                summerCamp = ["summerCamp - May / \(cureentYear)", "summerCamp - June/\(cureentYear)"]
            }
        }
        switch BookingDetails.package_id {
        
        case 1:
           
            if currentMonth < 5 {
                summerCamp = ["summerCamp - May / \(cureentYear)", "summerCamp - June/\(cureentYear)"]
            } else if currentMonth == 5 || 6 {
                
                if day < 15 {
                    
                   summerCamp = ["summerCamp - May / \(cureentYear)", "summerCamp - June/\(cureentYear)"]
                    
                } else {
                    
                    summerCamp = ["summerCamp - May / \(cureentYear + 1)", "summerCamp - June/\(cureentYear + 1)"]

                }
            } else {
                summerCamp = ["summerCamp - May / \(cureentYear + 1)", "summerCamp - June/\(cureentYear + 1)"]

            }
            
        
        case 2:
                  
                 
            if day < 15 {
                       
                       winterCamp = ["SummerCamp - January / \(cureentYear)","SummerCamp - Febraury / \(cureentYear)" ]
                   
                   } else {
                       
                       winterCamp = ["SummerCamp - January / \(cureentYear + 1)" ,"SummerCamp - Febrauary / \(cureentYear + 1)" ]

                   }
        case 3:
                  
                   if day < 15 {
                       
                       summerCamp = ["SummerCamp-May / \(cureentYear)"]
                   
                   } else {
                       
                       summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                       
                   }
        case 4:
                  
                   if day < 15 {
                       
                       summerCamp = ["SummerCamp-May / \(cureentYear)"]
                   
                   } else {
                       
                       summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                       
                   }
           
        case 5:
                      
                       if day < 15 {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear)"]
                       
                       } else {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                           
                       }
            case 6:
                      
                       if day < 15 {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear)"]
                       
                       } else {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                           
                       }
            
            case 7:
                      
                       if day < 15 {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear)"]
                       
                       } else {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                           
                       }
            case 8:
                      
                       if day < 15 {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear)"]
                       
                       } else {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                           
                       }
            case 9:
                      
                       if day < 15 {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear)"]
                       
                       } else {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                           
                       }
            case 10:
                      
                       if day < 15 {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear)"]
                       
                       } else {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                           
                       }
                        

            case 11:
                      
                       if day < 15 {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear)"]
                       
                       } else {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                           
                       }
            case 12:
                      
                       if day < 15 {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear)"]
                       
                       } else {
                           
                           summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]
                           
                       }
            
        default:
            break
        }
        
        
        if BookingDetails.package_id == "1" || BookingDetails.package_id == "6" {
                
            if currentMonth < 5 {
                
                    summerCamp = ["SummerCamp - May / \(cureentYear)", "SummerCamp - June / \(cureentYear)"]

            } else if currentMonth == 5 {
                
            } else if currentMonth > 5 {
            
            }
                        

            } else if currentMonth == 6 {
                
                if day < 15 {
                
                    summerCamp = ["SummerCamp -June / \(cureentYear)"]
                    
                    } else {
                        summerCamp = ["SummerCamp - June / \(cureentYear + 1)"]
                    
                }
                }
            
            } else if BookingDetails.package_id == "2" || BookingDetails.package_id == "7" {
               
          
            if currentMonth == 3 {
                       
                if day < 15 {
                       
                    summerCamp = ["SummerCamp-May / \(cureentYear)"]
               
                } else {
                   
                    summerCamp = ["SummerCamp-May / \(cureentYear + 1)"]

                   }
                           

               } else if currentMonth == 4 {
                   
                   if day < 15 {
                   
                    summerCamp = ["SpringCamp -June / \(cureentYear)"]
                       
                       
                   } else {
                   
                    summerCamp = ["SpringCamp - June / \(cureentYear + 1)"]
                       
                   }
                  
            }
            
           } else if BookingDetails.package_id == "3" || BookingDetails.package_id == "8" {

               if currentMonth == 11 {
                          
                   if day < 15 {
                          
                       summerCamp = ["PreWinterCamp - Novenber / \(cureentYear)"]
                  
                   } else {
                      
                       summerCamp = ["PreWinterCamp - Novenber / \(cureentYear + 1)"]

                      }
                              

                  } else if currentMonth == 4 {
                      
                      if day < 15 {
                      
                       summerCamp = ["SpringCamp -June / \(cureentYear)"]
                          
                          
                      } else {
                      
                       summerCamp = ["SpringCamp - June / \(cureentYear + 1)"]
                          
                      }
                     
               }
               
           } else if BookingDetails.package_id == "4" || BookingDetails.package_id == "9" {
               return winterCamp.count

           } else if BookingDetails.package_id == "5" || BookingDetails.package_id == "10" {
               return autumnCamp.count

           } else {
               print("No PID")
               return 0
           }
        
        
    }
    
    @IBAction func backAxn(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
   
    @IBAction func sibling_SC_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            
            sibling_SV.isHidden = true
            
        } else {
            
            sibling_SV.isHidden = false

            
        }
        
    }
    
    
    @IBAction func nextBtnAxn(_ sender: UIButton) {
        if seasonTF.text == "" || batchTF.text == "" || firstNameTF.text == "" || lastNameTF.text == "" || mobileTF.text == "" || emailTF.text == "" || DOBTF.text == "" || weightTF.text == "" || heightTF.text == "" || citizenShipTF.text == "" || TshirtTF.text == "" || motherTongueTF.text == "" {
        popUpAlert(title: "Alert", message: "Enter All Details", action: .alert)
        
        } else if mobileTF.text!.isValidContact() == false {
        sender.shake()
        popUpAlert(title: "Alert", message: "Enter a Valid Mobile Number", action: .alert)
        
        } else if emailTF.text!.isValidEmail() == false {
        sender.shake()
        popUpAlert(title: "Alert", message: "Enter Valid Email", action: .alert)
        
        } else if DOBTF.text!.getNoOfYears() > 35 || DOBTF.text!.getNoOfYears() < 14 {
        sender.shake()
        popUpAlert(title: "Alert", message: "Age should be 14 - 35 Years", action: .alert)
        
        } else if weightTF.text!.count > 3 || heightTF.text!.count > 3 {
            sender.shake()
            popUpAlert(title: "Weight/Height", message: "Not morethan 3 digits", action: .alert)
        } else {
      
            if isSibling == true {
            
            if sibling_FName_TF.text == "" {
                popUpAlert(title: "Alert", message: "Enter Sibling's FirstName", action: .alert)

            } else if sibling_LName_TF.text == "" {
                popUpAlert(title: "Alert", message: "Enter Sibling's LastName", action: .alert)

            } else if sibling_MobileTF.text == "" {
                popUpAlert(title: "Alert", message: "Enter Sibling's Mobile", action: .alert)

            } else if sibling_EmailTF.text == "" {
                popUpAlert(title: "Alert", message: "Enter Sibling's Email", action: .alert)

            } else  {
                BookingDetails.siblingsInfo = "NO"

                postDetails()
                }
            
            } else {
            
               BookingDetails.siblingsInfo = "NO"

                postDetails()
        }
        }
       
    }
    
    
    func postDetails() {
       
                BookingDetails.user_id = UserDetails.id
                BookingDetails.seasonal_camp = seasonTF.text!
                BookingDetails.camp_batch = batchTF.text!
                BookingDetails.first_name = firstNameTF.text!
                BookingDetails.last_name = lastNameTF.text!
                BookingDetails.mobile_number = mobileTF.text!
                BookingDetails.email = emailTF.text!
                BookingDetails.weight = weightTF.text!
                 BookingDetails.height = heightTF.text!
                BookingDetails.citizenship = citizenShipTF.text!
                BookingDetails.tshirt_size = TshirtTF.text!
                BookingDetails.mother_tonque = motherTongueTF.text!
                BookingDetails.DOB = DOBTF.text!
                
                BookingDetails.siblingsMobile = sibling_MobileTF.text!
                BookingDetails.siblingsFName = sibling_LName_TF.text!
                BookingDetails.siblingsLName = sibling_LName_TF.text!
              BookingDetails.siblingsEmail = sibling_EmailTF.text!


                
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ApplicationFormVC2") as! ApplicationFormVC2
                
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func DOBTF__Axn(_ sender: UITextField) {
        sender.pastDatePicker()
    }
    

    @IBAction func seasonTF_Axn(_ sender: UITextField) {
        sender.inputView = picker
        picker.reloadAllComponents()
    }
    
    @IBAction func genderSC_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
        BookingDetails.gender = "Female"
        print("Female")
      
        } else {
        BookingDetails.gender = "Male"
        print("MAle")
        }
    }
    
    
    @IBAction func siblingGender_Axn(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1  {
            BookingDetails.siblingsInfo = "NO"
        } else {
            BookingDetails.siblingsInfo = "YES"

        }
        
        
        
    }
    
    
    @IBAction func TShirtTF_Axn(_ sender: UITextField) {
        
        sender.inputView = picker
        picker.reloadAllComponents()
        
    }
    
    
    @IBAction func batch_Axn(_ sender: UITextField) {
        picker.reloadAllComponents()
        sender.inputView = picker
    }
    
    
    
}
extension ApplicatonFormVC1: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if seasonTF.isFirstResponder == true {
      
        if BookingDetails.package_id == "1" || BookingDetails.package_id == "6" {
            
            
            return summerCamp.count
     
        } else if BookingDetails.package_id == "2" || BookingDetails.package_id == "7" {
            return springCamp.count
        
        } else if BookingDetails.package_id == "3" || BookingDetails.package_id == "8" {
            return winterCamp.count
        
        } else if BookingDetails.package_id == "4" || BookingDetails.package_id == "9" {
            return winterCamp.count

        } else if BookingDetails.package_id == "5" || BookingDetails.package_id == "10" {
            return autumnCamp.count

        } else {
            print("No PID")
            return 0
        }
            
        } else if batchTF.isFirstResponder == true  {
       
            if BookingDetails.package_id == "1" ||  BookingDetails.package_id == "2" || BookingDetails.package_id == "3" || BookingDetails.package_id == "4" || BookingDetails.package_id == "5"  {
                return adultBatch.count

            } else {
                return childBatch.count
            }
            
        } else if TshirtTF.isFirstResponder == true {
            return TShirt_Arr.count
        } else {
            return 0
        }
    }
    

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if seasonTF.isFirstResponder == true {
            if BookingDetails.package_id == "1" || BookingDetails.package_id == "6" {
                seasonTF.text = summerCamp[row]

            } else if BookingDetails.package_id == "2" || BookingDetails.package_id == "7" {
               seasonTF.text = springCamp[row]
                
            } else if BookingDetails.package_id == "3" || BookingDetails.package_id == "8" {
                seasonTF.text = winterCamp[row]

            } else if BookingDetails.package_id == "4" || BookingDetails.package_id == "9" {
                seasonTF.text = winterCamp[row]

            } else if BookingDetails.package_id == "5" || BookingDetails.package_id == "10" {
                seasonTF.text = autumnCamp[row]

            } else {
                print("No PID")
            }
            
        } else if batchTF.isFirstResponder == true  {
            if BookingDetails.package_id == "1" ||  BookingDetails.package_id == "2" || BookingDetails.package_id == "3" || BookingDetails.package_id == "4" || BookingDetails.package_id == "5"  {
                batchTF.text = adultBatch[row]

                } else {
                batchTF.text = childBatch[row]
                }
        } else if TshirtTF.isFirstResponder == true {
         TshirtTF.text = TShirt_Arr[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
        pickerLabel = UILabel()
        pickerLabel?.font = UIFont(name: "Optima-Bold", size: 15)
        pickerLabel?.textAlignment = .center
        }
        pickerLabel?.textColor = .white

        if seasonTF.isFirstResponder == true {
        
            if BookingDetails.package_id == "1" || BookingDetails.package_id == "6" {
            pickerLabel?.text = summerCamp[row]

            } else if BookingDetails.package_id == "2" || BookingDetails.package_id == "7" {
            pickerLabel?.text = springCamp[row]
                
            } else if BookingDetails.package_id == "3" || BookingDetails.package_id == "8" {
                pickerLabel?.text = pre_winterCamp[row]

            } else if BookingDetails.package_id == "4" || BookingDetails.package_id == "9" {
                pickerLabel?.text = winterCamp[row]

            } else if BookingDetails.package_id == "5" || BookingDetails.package_id == "10" {
                pickerLabel?.text = autumnCamp[row]

            } else {
                print("No PID")
            }
            
        } else if batchTF.isFirstResponder == true  {
          
            if BookingDetails.package_id == "1" ||  BookingDetails.package_id == "2" || BookingDetails.package_id == "3" || BookingDetails.package_id == "4" || BookingDetails.package_id == "5"  {
                pickerLabel?.text = adultBatch[row]

                } else {
                pickerLabel?.text = childBatch[row]
                }
            
        } else if TshirtTF.isFirstResponder == true {
             pickerLabel?.text = TShirt_Arr[row]
       
        }

        return pickerLabel!
    }
    
    
    
}
