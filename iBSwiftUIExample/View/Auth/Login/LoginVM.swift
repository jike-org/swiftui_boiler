//
//  LoginVM.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-10.
//

import Foundation


class LoginVM : iBSLoginDelegate , ObservableObject{
    
    @Published var showMessage = false
    @Published var message = ""
    
    var formItems = [FormParameterItem]()
    
    //MARK: Delegate
    var loginService: iBSLogin?
    
    //MARK: Declare the form items here
    func setFormItems(email : String, password : String) {
        formItems.removeAll()
        let emailItem = FormParameterItem(itemType: .email, parameterKey: "email", parameterValue: email, comparingValue: nil, characterCount: 0, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .password)
        
        let passwordItem = FormParameterItem(itemType: .password, parameterKey: "password", parameterValue: password, comparingValue: nil, characterCount: Constant.Counts.passwordCount, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: nil)
        
        // Set form items
        formItems.append(emailItem)
        formItems.append(passwordItem)
    }
    
    //MARK: Local validation and proceed with login user web service
    func proceedWithLogin(withEmail email : String, password : String) {
        //MARK: 1. Set parameter items
        self.setFormItems(email: email, password: password)
        
        //MARK: 2. Get initial params
        let _initialParams = ASP.shared.initialAuthParameters
        
        //MARK: 3. Init login service and set delegate
        self.loginService = iBSLogin(initialParams: _initialParams, formItems: self.formItems)
        self.loginService?.delegate = self
        
        
        //MARK: 4. Local validation
        loginService?.validateLoginUser(completion: { status, message in
            
            switch status {
            case true:
                //MARK: 5. Login user web service
                loginService?.userLoginNetworkRequest(completion: { status, code, message, data in
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
                showMessage = true
                self.message = message
            }
        })
    }
}
