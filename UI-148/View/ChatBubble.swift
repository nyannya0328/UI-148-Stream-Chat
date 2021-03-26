//
//  ChatBubble.swift
//  UI-148
//
//  Created by にゃんにゃん丸 on 2021/03/26.
//

import SwiftUI

struct ChatBubble: Shape {
    var corner : UIRectCorner
    var size : Int
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

