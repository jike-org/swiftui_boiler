//
//  ChangePassword.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-24.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @State var oldPassword     : String = ""
    @State var newPassword     : String = ""
    @State var confirmPassword : String = ""
    
    @State var showOldPasscode   = false
    @State var showPasscode      = false
    @State var reShowPasscode    = false
    
    @ObservedObject var viewModel = ChangePasswordVM()
    
    var body: some View {
        VStack{
            
            VStack(alignment : .leading, spacing: 10){
                Text("Old Password")
                    .font(.caption)
                    .padding(.top, 20)
                
                    HStack(spacing: 15){
                        VStack{
                            if self.showOldPasscode{
                                TextField("Password", text: $oldPassword)
                                    .autocapitalization(.none)
                            }
                            else{
                                SecureField("Password", text: $oldPassword)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button(action: {
                            self.showOldPasscode.toggle()
                        }) {
                            
                            Image(systemName: self.showPasscode ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.black)
                        }
                        
                    }
                    .modifier(customTFStyle1())
                
                Text("New Password")
                    .font(.caption)
                    .padding(.top, 20)
                
                HStack(spacing: 15){
                    VStack{
                        if self.showPasscode{
                            TextField("Password", text: $newPassword)
                                .autocapitalization(.none)
                        }
                        else{
                            SecureField("Password", text: $newPassword)
                                .autocapitalization(.none)
                        }
                    }
                    
                    Button(action: {
                        self.showPasscode.toggle()
                    }) {
                        
                        Image(systemName: self.showPasscode ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.black)
                    }
                    
                }.modifier(customTFStyle1())
                
                Text("Confirm Password")
                    .font(.caption)
                    .padding(.top, 20)
                
                HStack(spacing: 15){
                    VStack{
                        if self.reShowPasscode{
                            TextField("Password", text: $confirmPassword)
                                .autocapitalization(.none)
                        }
                        else{
                            SecureField("Password", text: $confirmPassword)
                                .autocapitalization(.none)
                        }
                    }
                    
                    Button(action: {
                        self.reShowPasscode.toggle()
                    }) {
                        
                        Image(systemName: self.reShowPasscode ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.black)
                    }
                    
                }.modifier(customTFStyle1())
                
            }
            
            Button(action: {
                viewModel.proceedWithChangePassword(currentPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword)
            }, label: {
                Text("Submit")
            }).font(.headline)
            .padding(.top, 40)
        }.padding()
        .alert(isPresented: $viewModel.showMessage, content: {
            Alert(title: Text("Error"), message: Text(viewModel.message), dismissButton: .cancel())
        })
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
