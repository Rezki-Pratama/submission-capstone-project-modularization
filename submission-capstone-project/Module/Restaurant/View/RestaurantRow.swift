//
//  RestaurantRow.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI

import SwiftUI

struct RestaurantRow: View {
    var imageUrl: String
    var name: String
    var description: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
            HStack(alignment: .center) {
                RemoteImageView(
                    url: URL(string: "https://restaurant-api.dicoding.dev/images/small/\(imageUrl)")!,
                    placeholder: {
                      Image(systemName: "doc.on.doc").frame(width: 10) // etc.
                    },
                    image: {
                        $0.scaledToFit().frame(width: 120).padding(10).cornerRadius(7) // Inner corner radius
                             // Width of the border
                            .background(Color.primary) // Color of the border
                            .cornerRadius(10) // Outer corner radius
                    }
                )
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                    Text(description)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                        .lineLimit(3)
                }.padding(.all, 10)
                Spacer()
            }
        }
        .clipped()
        .shadow(radius: 2)
        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

struct CardRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantRow(imageUrl: "https://restaurant-api.dicoding.dev/images/small/14", name: "Melting Pot", description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...")
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
    
}
