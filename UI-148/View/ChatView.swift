//
//  ChatView.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/25.
//

import SwiftUI
import StreamChat

struct ChatView: View {
    @StateObject var listner : ChatChannelController.ObservableObject
    @Environment(\.colorScheme) var scheme
    @State var message = ""
    var body: some View {
        let channel = listner.controller.channel!
        
        VStack{
            
            ScrollViewReader{ reader in
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    LazyVStack(alignment: .center, spacing: 10, content: {
                        
                        ForEach(listner.messages.reversed(),id:\.self){msg in
                            
                            MessageRowView(message: msg)
                            
                        }
                        
                        
                        
                    })
                    .padding()
                    .padding(.bottom,10)
                    .id("MSG_View")
                    
                })
                .onChange(of: listner.messages) { (value) in
                    withAnimation{
                        
                        reader.scrollTo("MSG_View",anchor:.bottom)
                    }
                }
                
                .onAppear(perform: {
                    
                    reader.scrollTo("MSG_View",anchor:.bottom)
                    
                    
                })
               
                
            
            }
            
            HStack(spacing:10){
                
                TextField("Message", text: $message)
                    .modifier(ShadowModfier())
                
                
                Button(action:SendMessage) {
                    
                    Image(systemName: "paperplane.fill")
                        .padding(10)
                        .padding(.vertical,10)
                        .background(Color.primary)
                        .foregroundColor(scheme == .dark ? .black : .white)
                        .clipShape(Circle())
                        
                        
                    
                }
                .disabled(message == "")
                .opacity(message == "" ? 0.5 : 1)
                
                
            }
            .padding(.horizontal)
            .padding(.bottom,10)
            
           
                .navigationTitle(channel.cid.id)
        }
    }
    
    func SendMessage(){
        
        let ChannelID = ChannelId(type: .messaging, id: listner.channel?.cid.id ?? "")
        ChatClient.shared.channelController(for: ChannelID).createNewMessage(text: message){result in
            
            switch result{
            case .success(let id) : print("success\(id)")
            case .failure(let err) : print(err.localizedDescription)
            
            }
            
        }
        message = ""
        
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


