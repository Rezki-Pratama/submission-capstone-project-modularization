//
//  CustomBottomSheet.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 22/11/22.
//

import SwiftUI
import Core
import Restaurant
import Common

struct CustomBottomSheet: View {
  @ObservedObject var storePresenter: StorePresenter<[String: Any], String, Interactor<[String: Any], String, StoreRestaurantRepository<StoreRestaurantRemoteDataSource>>>
  
  @State var restaurant: RestaurantDomainModel?
  
  @State private var name = ""
  @State private var review = ""
  
  var body: some View {
    VStack {
      Text("add_review".localized(identifier: "rezki-pratama.submission-capstone-project"))
      TextField("name".localized(identifier: "rezki-pratama.submission-capstone-project"), text: $name)
                  .textFieldStyle(.roundedBorder)
                  .overlay(RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.gray, lineWidth: 1))
      TextEditor(text: $review)
                  .textFieldStyle(.roundedBorder)
                  .overlay(RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.gray, lineWidth: 1))
      Button(action: {
        
        var body: [String: Any] {
            return [
                "id": restaurant?.id ?? "",
                "name": name,
                "review": review,
            ]
        }
        
        storePresenter.store(request: body, completion: { isSucces in
          
        })
      }) {
        Text("save".localized(identifier: "rezki-pratama.submission-capstone-project"))
          .frame(maxWidth: .infinity)
      }
      .disabled(name.isEmpty && review.isEmpty)
      .buttonStyle(CustomButtonStyle())
    }
    .alert(isPresented: $storePresenter.showingAlert){
      Alert(
          title: Text("alert".localized(identifier: "rezki-pratama.submission-capstone-project")),
          message: Text(storePresenter.successMessage),
          dismissButton: .default(Text("close".localized(identifier: "rezki-pratama.submission-capstone-project")))
      )
    }
    .frame(minWidth: 0,maxWidth: .infinity,alignment: .topLeading)
    .padding(20)
  }
}
