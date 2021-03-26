//
//  MessageRowView.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/26.
//

import SwiftUI
import StreamChat

struct MessageRowView: View {
    var message : ChatMessage
    var body: some View {
        HStack{
            
            HStack{
                
                
                if message.isSentByCurrentUser{
                    
                    Spacer(minLength: 0)
                    
                }
                
                if !message.isSentByCurrentUser{
                    
                    userView(message: message)
                        .offset(y: 10)
                }
                
               
                
                HStack(alignment:.bottom,spacing:15){
                    
                    VStack(alignment: message.isSentByCurrentUser ? .trailing : .leading, spacing: 5, content: {
                        
                        Text(message.text)
                        
                        Text(message.createdAt,style: .time)
                        
                        
                    })
                    .padding([.horizontal,.top])
                    .padding(8)
                    .background(message.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.3))
                    .clipShape(ChatBubble(corner: message.isSentByCurrentUser ? [.topLeft,.topRight,.bottomLeft] : [.topLeft,.topRight,.bottomRight], size: 12))
                    .foregroundColor(message.isSentByCurrentUser ? .white : .primary)
                    .frame(width: UIScreen.main.bounds.width - 150,alignment: message.isSentByCurrentUser ? .trailing : .leading)
                    
                    if message.isSentByCurrentUser{
                        
                        userView(message: message)
                            .offset(y: 10)
                    }
                }
                
                
                if !message.isSentByCurrentUser{
                    
                    Spacer(minLength: 0)
                }
            }
        }
    }
}

struct MessageRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct userView : View {
    
    var message : ChatMessage
    var body: some View{
        
        Circle()
            .fill(message.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.3))
            .frame(width: 40, height: 40)
            .overlay(
            
                Text("\(String(message.author.id.first!))")
                    .fontWeight(.semibold)
                    .foregroundColor(message.isSentByCurrentUser ? .white : .primary)
                
                
            
            )
            .contextMenu(menuItems: {
                
                Text("\(message.author.id)")
                
                if message.author.isOnline{
                    
                    
                    Text("Statas:Online")
                }
                else{
                    
                    Text(message.author.lastActiveAt ?? Date(),style: .time)
                }
                
                
            })
        
    }
}
