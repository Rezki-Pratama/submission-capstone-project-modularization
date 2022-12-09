//
//  CustomButtonStyle.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 21/11/22.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
          .padding()
          .foregroundColor(.white)
          .background(configuration.isPressed ? Color.red : Color.blue)
          .cornerRadius(8.0)
  }
}
