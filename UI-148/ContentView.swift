//
//  ContentView.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/25.
//

import SwiftUI


struct ContentView: View {
    @StateObject var stremData = ChatStoreViewModel()
    @AppStorage("log_Statas") var logStatas = false
    var body: some View {
        NavigationView{
            
            if !logStatas{
                
                Login()
                    .navigationTitle("Login")
            }
            else{
                ChannelView()
               
            }
        }
        .alert(isPresented: $stremData.error, content: {
            Alert(title: Text(stremData.errMsg))
            
            
        })
        .overlay(
        
            ZStack{
                
                if stremData.createNewChannel{CreateNewChannel()}
                
                if stremData.isloading{
                    
                    LoadingScreen()
                }
                
            }
        
        )
        .environmentObject(stremData)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
