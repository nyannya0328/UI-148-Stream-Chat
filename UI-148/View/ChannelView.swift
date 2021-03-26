//
//  ChannelView.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/25.
//

import SwiftUI
import StreamChat

struct ChannelView: View {
    @EnvironmentObject var stremData : ChatStoreViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:15){
                
                
                if let channels = stremData.channels{
                    
                    ForEach(channels,id:\.channel){listner in
                        
                        NavigationLink(destination: ChatView(listner: listner)) {
                            ChannelRowView(listner: listner)
                        }
                    }
                    
                    
                }
                else{
                    
                    ProgressView()
                        .padding(.top,30)
                }
                
            }
            .padding()
            
        }
        .navigationTitle("Channel")
        .toolbar(content: {
            
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    
                    stremData.channels = nil
                    stremData.fetchChannel()
                    
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                }
                
            }
            
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    
                    stremData.createNewChannel.toggle()
                    
                    
                }) {
                    Image(systemName: "square.and.pencil")
                }
                
            }
        })
        .onAppear(perform: {
            
            stremData.fetchChannel()
            
        })
        
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView()
    }
}

struct ChannelRowView : View {
    
    @StateObject var listner : ChatChannelController.ObservableObject
    @EnvironmentObject var stremData : ChatStoreViewModel
    
    var body: some View{
        
        
        VStack(alignment: .trailing, spacing: 10) {
            
            HStack(spacing:15){
                
                
                let channel = listner.controller.channel!
                
                Circle()
                    .fill(Color.red.opacity(0.3))
                    .frame(width: 55, height: 55)
                    .overlay(
                        Text("\(String(channel.cid.id.first!))")
                    
                    )
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(channel.cid.id)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    
                    if let lastMsg = channel.latestMessages.first{
                        
                        
                        (
                            Text(lastMsg.isSentByCurrentUser ? "ME " : "\(lastMsg.author.id)")
                            
                            +
                            
                                Text(lastMsg.text)
                        
                        
                        )
                        .font(.caption)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        
                    }
                    
                }
                Spacer(minLength: 0)
                
                if let time = channel.latestMessages.first?.createdAt{
                    
                    
                    Text(time,style: CheckisDateToday(date: time) ? .time : .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
                .padding(.leading,10)
                .offset(y: 10)
            
        }
        .onAppear(perform: {
            
            
            listner.controller.synchronize()
        })
        .onChange(of: listner.controller.channel?.latestMessages.first?.text) { (value) in
            print("Sort Channel")
            sortChannels()
        }
    }
    func CheckisDateToday(date : Date) -> Bool{
        
        let carender = Calendar.current
        if carender.isDateInToday(date){
            
            return true
        }
        else{
            
            return false
        }
        
        
    }
    
    func sortChannels(){
        
        let result = stremData.channels.sorted { (ch1, ch2) -> Bool in
            if let date1 = ch1.channel?.latestMessages.first?.createdAt{
                
                
                if let date2 = ch2.channel?.latestMessages.first?.createdAt{
                    
                    return date1 > date2
                    
                }
                else{return false}
            }
            else{return false}
            
            
        }
        
        stremData.channels = result
       
        
        
        
        
        
    }
}
