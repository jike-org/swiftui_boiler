//
//  MenuView.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-10.
//

import SwiftUI

struct SideMenuView : View {
    @Binding var showSidebar : Bool
    @Binding var selection : AnyView?
    // Menu items
    var menuItems : [MenuItem] =  [
        MenuItem(itemName: "Home", itemImage: "emlogo", destination: AnyView(HomeView())),
        MenuItem(itemName: "My Profile", itemImage: "emlogo", destination: AnyView(ProfileView())),
        MenuItem(itemName: "About Us", itemImage: "emlogo", destination: AnyView(DetailsView(viewName: "About Us"))),
        MenuItem(itemName: "Notifications", itemImage: "emlogo", destination: AnyView(DetailsView(viewName: "Notifications"))),
        MenuItem(itemName: "Terms and Conditions", itemImage: "emlogo", destination: AnyView(DetailsView(viewName: "Terms and Conditions"))),
        MenuItem(itemName: "Contact Us", itemImage: "emlogo", destination: AnyView(DetailsView(viewName: "Contact Us"))),
        MenuItem(itemName: "Privacy Policy", itemImage: "emlogo", destination: AnyView(DetailsView(viewName: "Privacy Policy"))),
        MenuItem(itemName: "Log Out", itemImage: "emlogo", destination: AnyView(DetailsView(viewName: "Log Out")))
    ]
    
    
    var body: some View {
        ZStack(alignment: .topTrailing){
//            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
               
            Color(UIColor.darkGray)
                .ignoresSafeArea()
            Button(action: {
                withAnimation(.spring()) {
                    showSidebar.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    
            })
            .frame(width: 50, height: 50)
            
            VStack(spacing : 5){
                
                ForEach(menuItems) { item in
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            showSidebar.toggle()
                            if(item.itemName == "Log Out" ){
                                PersistenceController.shared.deleteUserData()
                                Authenticated.send(false)
                                SwaggerClientAPI.customHeaders.removeValue(forKey: "x-access-token")
                            }else{
                                self.selection = item.destination ?? AnyView(Text(""))
                            }
                        }
                    }, label: {
                        SideMenuItemView(itemName: item.itemName, itemImage: item.itemImage)
                    })
                }
                // Go to destination with navigation bar
//                ForEach(menuItems) { item in
//                    NavigationLink(
//                        destination: item.destination,
//                        label: {
//                            SideMenuItemView(itemName: item.itemName, itemImage: item.itemImage)
//                        })
//                }
                Spacer()
            }.padding(.top, 30)
        }
        .navigationBarHidden(true)
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.width < 0 {
                            withAnimation(.spring()){
                                showSidebar.toggle()
                            }
                        }
                        
                        if value.translation.width > 0 {
                            withAnimation(.spring()){
                                showSidebar.toggle()
                            }
                        }
                    }))
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(showSidebar: .constant(true), selection: .constant(AnyView(DetailsView(viewName: "Home"))))
    }
}
