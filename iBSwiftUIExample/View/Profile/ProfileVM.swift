//
//  ProfileViewModel.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-23.
//

import SwiftUI


class ProfileVM : iBSUpdateProfileDelegate, iBSViewProfileDelegate , ObservableObject{
    
    @Published var showMessage = false
    @Published var message = ""
    
    var viewProfileService: iBSViewProfile?
    var updateProfileService: iBSUpdateProfile?
    
    
    //MARK: Store form items
    var formItems = [FormParameterItem]()
    
    //MARK: Declare the form items here
    func setFormItems(firstName : String, lastName : String, email : String) {
        
        let firstNameItem = FormParameterItem(itemType: .firstName, parameterKey: "first_name", parameterValue: firstName, comparingValue: nil, characterCount: 0, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .lastName)
        
        let lastNameItem = FormParameterItem(itemType: .lastName, parameterKey: "last_name", parameterValue: lastName, comparingValue: nil, characterCount: 0, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .email)
        
        let emailItem = FormParameterItem(itemType: .email, parameterKey: "email", parameterValue: email, comparingValue: nil, characterCount: 0, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .countryCode_phone)
        
       
        // Set form items
        formItems = [firstNameItem, lastNameItem, emailItem]
    }
    
    
    //MARK: Proceed with view profile web service
    func proceedWithViewProfile() {
        
        //MARK: 1. Set delegate
        viewProfileService = iBSViewProfile()
        viewProfileService?.delegate = self
        
        
        //MARK: 2. View profile info web service
        viewProfileService?.viewProfileInfoNetworkRequest(completion: { status, code, message, data in
            switch status {
            case true:
                if let _payloadDict = data as? PayloadDictionary {
                    
                    // Init User from PayloadDictionary
//                    let _user = User(from: _payloadDict)

                } else {
                    self.showMessage = true
                    self.message = message
                }
            default:
                self.showMessage = true
                self.message = message
            }
        })
    }
    
    //MARK: Local validation and proceed with update profile info web service
    func proceedWithUpdateProfileInfo(firstName : String, lastName : String, email : String) {
        
        //MARK: 1. Set parameter items
        self.setFormItems(firstName : firstName, lastName : lastName, email : email)
        
        //MARK: 2. Get initial params
        let _initialParams = ASP.shared.initialAuthParameters
        
        //MARK: 3. Init update profile info service and set delegate
        self.updateProfileService = iBSUpdateProfile(initialParams: _initialParams, formItems: self.formItems)
        self.updateProfileService?.delegate = self
        
        
        //MARK: 4. Local validation
        updateProfileService?.validateUpdateProfile(completion: { status, message in
            
            switch status {
            case true:
                //MARK: 5. Update profile info web service
                updateProfileService?.updateProfileInfoNetworkRequest(completion: { status, code, message, data in
                    switch status {
                    case true:
                        if let _payloadDict = data as? PayloadDictionary {
                            
                            // Init User from PayloadDictionary
                            let _user = User(from: _payloadDict)
                            
                            // Update local user
                            PersistenceController.shared.updateUserData(with: _user)
//                            LocalUser.UpdateProfileData(type: .Info, user: _user)
                            
//                            completion(true, code, message, _user)
                        } else {
                           self.showMessage = true
                           self.message = message
                        }
                    default:
                        self.showMessage = true
                        self.message = message
                    }
                })
            default:
               self.showMessage = true
                self.message = message
            }
        })
    }
    
    
    //MARK: Proceed with update profile picture web service
    func proceedWithUpdateProfilePicture(url: URL) {
        
        //MARK: 1. Init update profile pictire service and set delegate
        self.updateProfileService = iBSUpdateProfile(initialParams: [:], formItems: [])
        self.updateProfileService?.delegate = self
        
        
        //MARK: 2. Update profile picture web service
        updateProfileService?.updateProfilePictureNetworkRequest(url: url, completion: { status, code, message, data in
            switch status {
            case true:
                if let _payloadDict = data as? PayloadDictionary {
                    
                    // Init User from PayloadDictionary
                    let _user = User(from: _payloadDict)
                    
                    // Update local user
//                    LocalUser.UpdateProfileData(type: .Avatar, user: _user)
                    PersistenceController.shared.updateUserData(with: _user)
                    
//                    completion(true, code, message, _user)
                } else {
                    self.showMessage = true
                    self.message = message
                }
            default:
                self.showMessage = true
                self.message = message
            }
        })
    }
    
}

