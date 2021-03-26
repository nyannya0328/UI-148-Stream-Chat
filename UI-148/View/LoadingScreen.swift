//
//  LoadingScreen.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/25.
//

import SwiftUI

struct LoadingScreen: View {
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack{
            
            Color.primary.opacity(0.3)
                .ignoresSafeArea()
            
            ProgressView()
                .frame(width: 50, height: 50)
                .background(scheme == .dark ? Color.black : Color.white)
                .cornerRadius(8)
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
