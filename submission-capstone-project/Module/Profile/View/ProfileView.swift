//
//  ProfileView.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
        Image(uiImage: UIImage(named: "image")!)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .border(Color.pink)
            .clipped()
            .clipShape(Circle())
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 20)
            Text("Nama")
            Text("Rezki Pratama").fontWeight(.bold)
            Spacer().frame(height: 20)
            Text("Email")
            Text("rezki.pratama7777@gmail.com").fontWeight(.bold)
            Spacer().frame(height: 20)
            Text("Github")
            Text("https://github.com/Rezki-Pratama").fontWeight(.bold)
        }
    }.fixedSize(horizontal: true, vertical: false)
  }
}
