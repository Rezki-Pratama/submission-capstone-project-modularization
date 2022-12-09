//
//  RestaurantView.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI
import Core
import Restaurant
import Common

struct RestaurantView: View {
  @ObservedObject var presenter: GetListPresenter<Any, RestaurantDomainModel, Interactor<Any, [RestaurantDomainModel], GetRestaurantsRepository<GetRestaurantLocalDataSource, GetRestaurantsRemoteDataSource, RestaurantsTransformer>>>
  @State private var alert: Bool = false

  var body: some View {
    VStack {
      HStack {
          Image(systemName: "magnifyingglass")
              .resizable()
              .frame(width: 30, height: 30, alignment: .center)
          TextField("search".localized(identifier: "rezki-pratama.submission-capstone-project"), text: $presenter.search)
          Button(action: {
              self.alert = true
          }){
              Text("filter".localized(identifier: "rezki-pratama.submission-capstone-project"))
          }
      }
      .padding(.horizontal)
      if presenter.resourceState == .loading {
        Spacer()
        ProgressIndicator(color: Color.blue, size: 40, lineWidth: 5.0)
      } else if presenter.resourceState == .error {
        Spacer()
        Text(presenter.errorMessage)
      } else if presenter.resourceState == .success {
        List(presenter.list) { restaurant in
          self.presenter.linkBuilder(
               title: "detail_restaurant".localized(identifier: "rezki-pratama.submission-capstone-project"),
               destination: {
                 RestaurantRouter.makeDetailView(for: restaurant)
               },content: {
                 RestaurantRow(imageUrl: restaurant.pictureId, name: restaurant.name, description: restaurant.description)
               })
          
        }.navigationBarTitleDisplayMode(.inline)
      }
      Spacer()
    }
    .background(Color.white)
    .onAppear {
        if self.presenter.list.count == 0 {
          self.presenter.getList(search: "")
        }
        UITableView.appearance().contentInset.top = -35
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
        UITableViewCell.appearance().backgroundColor = .none
        UITableView.appearance().backgroundColor = .none
    }
  }
}
