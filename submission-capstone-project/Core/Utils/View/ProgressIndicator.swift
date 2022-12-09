//
//  ProgressIndicator.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI

struct ProgressIndicator: View {
    @State private var degress = 0.0
    let color: Color
    let size: CGFloat
    let lineWidth: CGFloat
    var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.8)
            .stroke(color, lineWidth: lineWidth)
            .frame(width: size, height: size)
            .rotationEffect(Angle(degrees: degress))
            .onAppear{ self.start()}
    }
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            withAnimation {
                self.degress += 10.0
            }
            if self.degress == 360.0 {
                self.degress = 0.0
            }
        }
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator(color: Color.gray, size: 50, lineWidth: 10.0)
    }
}
