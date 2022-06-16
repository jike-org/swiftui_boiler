//
//  Login.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-02.
//

import SwiftUI

struct LoginView: View {
    @State var color = Color.black.opacity(0.7)
    @State var email : String = ""
    @State var password : String = ""
    @State var isSignupLinkActive = false
    @State var isForgotPasspLinkActive = false
    @State var showPasscode = false
    
    @ObservedObject var viewModel : LoginVM
    
    var body: some View {
        NavigationView{
            ScrollView {
            VStack(spacing: 20) {
                Image("emBanner")
                    .resizable()
                    .frame(width: 250, height: 150)
                    .clipped()
                VStack(alignment : .leading){
                    Text("Email")
                        .font(.caption)
                        .padding(.top, 20)
                        .keyboardType(.emailAddress)
                    TextField("", text: $email)
                        .font(.caption)
                        .modifier(customTFStyle1(color: color))
                        .validate(with: email, validation: Validators().isValidEmailValidator)
                    Text("Password")
                        .font(.subheadline)
                        .padding(.top, 20)
                    HStack(spacing: 15){
                        VStack{
                            if self.showPasscode{
                                TextField("", text: self.$password)
                                    .autocapitalization(.none)
                            }
                            else{
                                SecureField("", text: self.$password)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button(action: {
                            self.showPasscode.toggle()
                        }) {
                            
                            Image(systemName: self.showPasscode ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                        
                    }
                    .modifier(customTFStyle1(color: color))
                    .validate(with: password, validation: Validators().isValidPasswordValidator)
                }
                Button(action: {
                    viewModel.proceedWithLogin(withEmail: email, password: password)
                }) {
                    Text("Login")
                        .font(.headline)
                    
                }.padding(.top, 10)
                
                NavigationLink(
                    destination: ForgotPasswordView(),
                    isActive: $isForgotPasspLinkActive){
                    
                    Button("Forgot Password") {
                        isForgotPasspLinkActive.toggle()
                    }.padding(.top, 20)
                }
               
                
                Button(action: {
                    let user = User(_id: "0", uuid: UUID().uuidString, firstName: nil, lastName: nil, fullName: nil, email: nil, avatarUrl: nil, timezone: nil, accessToken: nil, userRole: .Guest)
                    PersistenceController.shared.saveUserData(with: user)
                    Authenticated.send(true)
                }) {
                    Text("Guest")
                        .font(.headline)
                    
                }.padding(.top, 10)
                
                Spacer()
                HStack{
                    Text("Don't you have an account?")
                    NavigationLink(destination: SignupView(), isActive: $isSignupLinkActive) {
                        Button(action: {
                            self.isSignupLinkActive = true
                        }) {
                            Text("Sign Up")
                                .font(.headline)
                            
                        }
                    }
                }
                
                .navigationBarTitle("Sign In")
                
            }.padding()
            .alert(isPresented: $viewModel.showMessage, content: {
                Alert(title: Text("Error"), message: Text(viewModel.message), dismissButton: .cancel())
            })
        }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginVM())
    }
}

struct customTFStyle1: ViewModifier {
    var color: Color = Color.black.opacity(0.7)
    
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(color,lineWidth: 2))
            .padding(.top, 5)
    }
}
