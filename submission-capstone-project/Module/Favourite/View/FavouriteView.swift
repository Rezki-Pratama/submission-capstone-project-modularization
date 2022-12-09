//
//  FavouriteView.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI
import Favourite
import Restaurant
import Core

struct FavouriteView: View {
  @ObservedObject var presenter: FavouritesPresenter<
    Interactor<RestaurantDomainModel,Bool,StoreFavouriteRepository<GetFavouriteLocalDataSource,FavouriteTransformer>>,
    Interactor<Any,[RestaurantDomainModel],GetFavouritesRepository<GetFavouriteLocalDataSource,FavouritesTransformer>>,
    Interactor<String,FavouriteModuleEntity,GetFavouriteRepository<GetFavouriteLocalDataSource>>,
    Interactor<FavouriteModuleEntity,Bool,DeleteFavouriteRepository<GetFavouriteLocalDataSource>>
  >
  
  @State private var alert: Bool = false
  var body: some View {
    VStack {
      if presenter.resourceState == .loading {
        Spacer()
        ProgressIndicator(color: Color.blue, size: 40, lineWidth: 5.0)
      } else if presenter.resourceState == .error {
        Spacer()
        Text(presenter.errorMessage)
      } else if presenter.resourceState == .empty {
        Spacer()
        Text("No Data")
      } else if presenter.resourceState == .success {
        List(presenter.list) { favourite in
          self.presenter.linkBuilder(
               title: "Detail Restaurant",
               destination: {
                 RestaurantRouter.makeDetailView(for: favourite)
               },content: {
                 RestaurantRow(imageUrl: favourite.pictureId, name: favourite.name, description: favourite.description)
               })
          
        }.navigationBarTitleDisplayMode(.inline)
      }
      Spacer()
    }
    .background(Color.white)
    .onAppear {
        self.presenter.getFavourites()
        UITableView.appearance().contentInset.top = -35
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
        UITableViewCell.appearance().backgroundColor = .none
        UITableView.appearance().backgroundColor = .none
    }
  }
}
