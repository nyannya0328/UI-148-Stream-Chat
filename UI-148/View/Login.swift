//
//  Login.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/25.
//

import SwiftUI


struct Login: View {
    @EnvironmentObject var stremData : ChatStoreViewModel
    @Environment(\.colorScheme) var scheme
    var body: some View {
        VStack{
            
            TextField("Enter", text: $stremData.username)
                .modifier(ShadowModfier())
                .padding(.top,30)
            Button(action: stremData.loginUser) {
                HStack{
                    
                    Spacer()
                    
                    Text("Login")
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                    
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.primary)
                .foregroundColor(scheme == .dark ? .black : . white)
                .cornerRadius(8)
                
            }
            .padding(.top,20)
            .disabled(stremData.username == "")
            .opacity(stremData.username == "" ? 0.5 : 1)
            
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

struct ShadowModfier : ViewModifier {
    @Environment(\.colorScheme) var scheme
    func body(content: Content) -> some View {
        return content
            .padding(.vertical,10)
            .padding(.horizontal)
           
            .background(scheme != .dark ? Color.white : Color.black)
            .clipped()
            .shadow(color: Color.primary.opacity(0.03), radius: 5, x: 5, y: 5)
            .shadow(color: Color.primary.opacity(0.03), radius: 5, x: -5, y: -5)
        
    }
}
