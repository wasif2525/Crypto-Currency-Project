//
//  CircleButtonAnimation.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/9/24.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(.easeOut(duration: 1.0), value: animate)
            
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(true))
}
