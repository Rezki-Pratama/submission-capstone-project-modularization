//
//  CustomBottomSheet.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 22/11/22.
//

import SwiftUI
import Core
import Restaurant

struct CustomBottomSheet: View {
  @ObservedObject var storePresenter: StorePresenter<[String: Any], String, Interactor<[String: Any], String, StoreRestaurantRepository<StoreRestaurantRemoteDataSource>>>
  
  @State var restaurant: RestaurantDomainModel?
  
  @State private var name = ""
  @State private var review = ""
  
  var body: some View {
    VStack {
      Text("Add new review")
      TextField("Name", text: $name)
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
        Text("Save")
          .frame(maxWidth: .infinity)
      }
      .disabled(name.isEmpty && review.isEmpty)
      .buttonStyle(CustomButtonStyle())
    }
    .alert(isPresented: $storePresenter.showingAlert){
      Alert(
          title: Text("Alert"),
          message: Text(storePresenter.successMessage),
          dismissButton: .default(Text("Close"))
      )
    }
    .frame(minWidth: 0,maxWidth: .infinity,alignment: .topLeading)
    .padding(20)
  }
}
