//
//  UI_148App.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/25.
//

import SwiftUI
import StreamChat

@main
struct UI_148App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var Delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate : NSObject,UIApplicationDelegate{
    @AppStorage("storedUser") var storedUser = ""
    @AppStorage("log_Statas") var logStatas = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let config = ChatClientConfig(apiKeyString: APIkey)
        
        if logStatas{
            
            ChatClient.shared = ChatClient(config: config, tokenProvider: .development(userId: storedUser))
            
            
            
            
        }
        
        else{
            
            ChatClient.shared = ChatClient(config: config, tokenProvider: .anonymous)
            
            
        }
        
        return true
    }
}

extension ChatClient{
    
    static var shared : ChatClient!
}
