//
//  SignupVM.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-11.
//

import Foundation

class SignupVM : iBSRegisterDelegate, ObservableObject{
    
    @Published var showMessage = false
    @Published var message = ""
    
    var registerService: iBSRegister?
    
    //MARK: Store form items
    var formItems = [FormParameterItem]()
    
    
    //MARK: Declare the form items here
    func setFormItems(firstName : String, lastName : String, email : String, password : String, confirmPassword : String) {
        
        let firstNameItem = FormParameterItem(itemType: .firstName, parameterKey: "first_name", parameterValue: firstName, comparingValue: nil, characterCount: 0, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .lastName)
        
        let lastNameItem = FormParameterItem(itemType: .lastName, parameterKey: "last_name", parameterValue: lastName, comparingValue: nil, characterCount: 0, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .email)
        
        let emailItem = FormParameterItem(itemType: .email, parameterKey: "email", parameterValue: email, comparingValue: nil, characterCount: 0, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .countryCode_phone)
        
        let passwordItem = FormParameterItem(itemType: .password, parameterKey: "password", parameterValue: password, comparingValue: nil, characterCount: Constant.Counts.passwordCount, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .confirmPassword)
        
        let confirmPasswordItem = FormParameterItem(itemType: .confirmPassword, parameterKey: "password_confirmation", parameterValue: confirmPassword, comparingValue: password, characterCount: Constant.Counts.passwordCount, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: nil)
        
        // Set form items
        formItems = [firstNameItem, lastNameItem, emailItem, passwordItem, confirmPasswordItem]
    }
    
    
    //MARK: Local validation and proceed with register user web service
    func proceedWithRegister(firstName : String, lastName : String, email : String, password : String, confirmPassword : String) {
        
        //MARK: 1. Set parameter items
        self.setFormItems(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword)
        
        //MARK: 2. Get initial params
        let _initialParams = ASP.shared.initialAuthParameters
        
        //MARK: 3. Init register service and set delegate
        self.registerService = iBSRegister(initialParams: _initialParams, formItems: self.formItems)
        self.registerService?.delegate = self
        
        
        //MARK: 4. Local validation
        registerService?.validateRegisterUser(completion: { status, message in
            
            switch status {
            case true:
                //MARK: 5. Register user web service
                registerService?.userRegistrationNetworkRequest(completion: { status, code, message, data in
                    switch status {
                    case true:
                        if let _payloadDict = data as? PayloadDictionary {
                            
                            // Init User from PayloadDictionary
                            let _user = User(from: _payloadDict)
                            
                            // Save local user
                            PersistenceController.shared.saveUserData(with: _user)
                            Authenticated.send(true)
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
}


