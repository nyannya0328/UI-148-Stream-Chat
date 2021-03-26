//
//  ChatStoreViewModel.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/25.
//

import SwiftUI
import StreamChat

class ChatStoreViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var error = false
    
    @Published var errMsg = ""
    @Published var isloading = false
    
    @Published var channels : [ChatChannelController.ObservableObject]!
    
    @Published var createNewChannel = false
    @Published var channelName = ""
    
    @AppStorage("storedUser") var storedUser = ""
    @AppStorage("log_Statas") var logStatas = false
    
    
    
    func loginUser(){
        
        withAnimation{isloading = true}
        let config = ChatClientConfig(apiKeyString: APIkey)
        
        ChatClient.shared = ChatClient(config: config, tokenProvider: .development(userId: username))
        ChatClient.shared.currentUserController().reloadUserIfNeeded { (err) in
            withAnimation{self.isloading = false}
            if let error = err{
                
                self.errMsg = error.localizedDescription
                self.error.toggle()
                
                return
            }
            
            self.storedUser = self.username
            self.logStatas = true
        }
    }
    
    func fetchChannel(){
        
        
        if channels == nil{
            
            let filter = Filter<ChannelListFilterScope>.equal("type", to: "messaging")
            
            let request = ChatClient.shared.channelListController(query: .init(filter: filter))
            
            request.synchronize { (err) in
                if let error = err{
                    
                    self.errMsg = error.localizedDescription
                    self.error.toggle()
                    return
                    
                }
                
                self.channels = request.channels.compactMap({ (channel) -> ChatChannelController.ObservableObject? in
                    return ChatClient.shared.channelController(for: channel.cid).observableObject
                })
                
            }
            
            
        }
        
    }
    
    func createChannel(){
        
        withAnimation{self.isloading = true}
        
        let newChannel = ChannelId(type:.messaging,id:channelName)
        let request = try! ChatClient.shared.channelController(createChannelWithId: newChannel, name: channelName, imageURL: nil, extraData: .defaultValue)
        
            request.synchronize({ (err) in
                withAnimation{self.isloading = false}
                if let error = err{
                    
                    self.errMsg = error.localizedDescription
                    self.error.toggle()
                    return
                }
                self.channelName = ""
                    withAnimation{self.createNewChannel = false}
                
            })
        
        
        
        
        
    }
}

