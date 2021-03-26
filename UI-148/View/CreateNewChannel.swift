//
//  CreateNewChannel.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/25.
//

import SwiftUI

struct CreateNewChannel: View {
    @Environment(\.colorScheme) var scheme
    @EnvironmentObject var stremData : ChatStoreViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Create New Channel")
                .font(.title2)
            
            TextField("Enter", text:$stremData.channelName)
                .modifier(ShadowModfier())
            
            Button(action: stremData.createChannel) {
                Text("Create Channel")
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.primary)
                    .foregroundColor(scheme == .dark ? Color.black : Color.white)
                    .cornerRadius(8)
                
                
            }
            .padding(.top,20)
            .disabled(stremData.channelName == "")
            .opacity(stremData.channelName == "" ? 0.5 : 1)
               
                
            
        }
        .padding()
        .background(scheme == .dark ? Color.black : Color.white)
        .cornerRadius(8)
        .padding(.horizontal,35)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.ignoresSafeArea().onTapGesture {
            stremData.channelName = ""
            withAnimation{stremData.createNewChannel.toggle()}
        })
        
    }
}

struct CreateNewChannel_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewChannel()
    }
}
