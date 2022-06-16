//
//  ForgotPasswordVM.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-24.
//

import SwiftUI

class ForgotPasswordVM : iBSForgotPasswordDelegate, ObservableObject {
    
    @Published var showMessage = false
    @Published var message = ""
    
    var retrivePasswordService: iBSForgotPassword?
    
    var formItems = [FormParameterItem]()
    
    
    //MARK: Declare the form items here
    func setFormItems(email : String) {
        
        let emailItem = FormParameterItem(itemType: .email, parameterKey: "email", parameterValue: email, comparingValue: nil, characterCount: 0, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .password)
        
        // Set form items
        formItems = [emailItem]
    }
    
    //MARK: Local validation and proceed with retrive password web service
    func proceedWithRetrivePassword(email: String) {
        
        //MARK: 1. Set parameter items
        self.setFormItems(email: email)
        
        //MARK: 2. Get initial params
        let _initialParams: [String: Any] = [:]
        
        //MARK: 3. Init retrieve password service and set delegate
        self.retrivePasswordService = iBSForgotPassword(initialParams: _initialParams, formItems: self.formItems)
        self.retrivePasswordService?.delegate = self
        

        //MARK: 4. Local validation
        retrivePasswordService?.validateRetrivePassword(completion: { status, message in
            
            switch status {
            case true:
                //MARK: 5. Login user web service
                retrivePasswordService?.retrivePasswordNetworkRequest(completion: { status, code, message, data in
                    switch status {
                    case true:
                       break
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


