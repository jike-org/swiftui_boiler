//
//  SideMenuItemView.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-10.
//

import SwiftUI

struct SideMenuItemView: View {
    var itemName : String
    var itemImage : String?
    var body: some View {
        HStack(spacing : 12){
            Image(itemImage ?? "")
                .resizable()
                .frame(width: 24, height: 24)
                .clipShape(Circle())
            
            Text(itemName)
                .foregroundColor(Color(UIColor.white))
                .font(.system(size: 15, weight : .semibold))
                .frame(width: 150, alignment: .leading)
                .lineLimit(nil)
            Spacer()
        }
        .frame(alignment: .leading)
        .padding()
    }
}

struct SideMenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuItemView(itemName: "Test 1", itemImage: "emlogo")
    }
}



struct MenuItem : Identifiable {
    var id =  UUID()
    var itemName : String
    var itemImage : String?
    var destination : AnyView?
}



struct MenuButton: ViewModifier {
    @Binding var showSidebar : Bool
    func body(content: Content) -> some View {
        content
            .cornerRadius(showSidebar ? 10 : 0)
            .offset(x: showSidebar ? 200 : 0, y: 0)
            .scaleEffect(showSidebar ? 0.8 : 1)
            .navigationBarItems(leading: Button(action: {
                withAnimation(.spring()){
                    showSidebar.toggle()
                }
                
            }, label: {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.black)
                    .padding(5)
            }))
    }
}
