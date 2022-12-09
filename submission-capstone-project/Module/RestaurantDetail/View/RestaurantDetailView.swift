//
//  RestaurantDetailView.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 21/11/22.
//

import SwiftUI
import Restaurant
import Favourite
import Core
import Common

struct RestaurantDetailView: View {
  
  @ObservedObject var presenter: GetDetailPresenter<Any, RestaurantDomainModel, Interactor<Any, RestaurantDomainModel, GetRestaurantRepository<GetRestaurantRemoteDataSource, RestaurantTransformer>>>
  
  @ObservedObject var storePresenter: StorePresenter<[String: Any], String, Interactor<[String: Any], String, StoreRestaurantRepository<StoreRestaurantRemoteDataSource>>>
  
  @ObservedObject var favouritePresenter: FavouritesPresenter<
    Interactor<RestaurantDomainModel,Bool,StoreFavouriteRepository<GetFavouriteLocalDataSource,FavouriteTransformer>>,
    Interactor<Any,[RestaurantDomainModel],GetFavouritesRepository<GetFavouriteLocalDataSource,FavouritesTransformer>>,
    Interactor<String,FavouriteModuleEntity,GetFavouriteRepository<GetFavouriteLocalDataSource>>,
    Interactor<FavouriteModuleEntity,Bool,DeleteFavouriteRepository<GetFavouriteLocalDataSource>>
  >
  
  @State var restaurant: RestaurantDomainModel?
  
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
              Text("no_data".localized(identifier: "rezki-pratama.submission-capstone-project"))
          } else if presenter.resourceState == .success {
              List {
                Spacer().frame(height: 20)
                  VStack(alignment: .leading, spacing: 0) {
                    let detail = presenter.detail
                      RemoteImageView(
                          url: URL(string: "https://restaurant-api.dicoding.dev/images/small/\(detail?.pictureId ?? "")")!,
                          placeholder: {
                            Image(systemName: "doc.on.doc").frame(width: 10) // etc.
                          },
                          image: {
                              $0.scaledToFit().padding(5).cornerRadius(7) // Inner corner radius
                                  .background(Color.primary) // Color of the border
                                  .cornerRadius(10) // Outer corner radius
                          }
                      )
                      Group {
                        Spacer().frame(height: 10)
                        Text(detail?.name ?? "")
                          .font(.system(size: 25))
                          .fontWeight(.bold)
                        Text("\(detail?.address ?? ""), \(detail?.city ?? "")")
                          .font(.system(size: 20))
                          .fontWeight(.medium)
                        Spacer().frame(height: 10)
                        Text(detail?.description ?? "")
                        Spacer().frame(height: 20)
                      }
                      HStack {
                        Text("review".localized(identifier: "rezki-pratama.submission-capstone-project"))
                          .font(.system(size: 20))
                          .fontWeight(.bold)
                        Spacer()
                        Button {
                          presenter.showBottomSheet.toggle()
                        } label: {
                          Text("add_review".localized(identifier: "rezki-pratama.submission-capstone-project"))
                        }
                        .buttonStyle(.borderless)
                        .sheet(isPresented: $presenter.showBottomSheet) {
                          CustomBottomSheet(storePresenter: storePresenter, restaurant: restaurant)
                            .onDisappear {
                              print(favouritePresenter.isFavourite)
                              presenter.showBottomSheet = false
                              presenter.getDetail(from: restaurant?.id ?? "")
                              favouritePresenter.getFavouriteById(id: restaurant?.id ?? "")
                            }
                        }
                      }
                      Spacer().frame(height: 10)
                      ForEach(detail?.customerReviews ?? [],id: \.self) { review in
                        VStack(alignment: .leading) {
                          VStack(alignment: .leading) {
                            Text(review.name ?? "")
                            Text(review.date ?? "")
                            Text(review.review ?? "")
                              .foregroundColor(Color.gray)
                            Spacer().frame(height: 5)
                          }
                          .padding(5)
                          .frame(minWidth: 0,maxWidth: .infinity,alignment: .topLeading)
                          .overlay(RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.black, lineWidth: 1))
                          Spacer().frame(height: 10)
                        }
                      }

                  }
              }.listStyle(PlainListStyle())
          }
          Spacer()
      }
      .navigationBarItems(trailing: Button {
        if favouritePresenter.isFavourite {
          favouritePresenter.deleteFavourite()
        } else {
          favouritePresenter.addFavourite(request: restaurant!)
        }
      } label: {
        if favouritePresenter.isFavourite {
          Image(systemName: "heart.fill")
        } else {
          Image(systemName: "heart")
        }
      })
      .padding()
      .background(Color.white)
      .onAppear {
          print(favouritePresenter.isFavourite)
          presenter.getDetail(from: restaurant?.id ?? "")
          favouritePresenter.getFavouriteById(id: restaurant?.id ?? "")
          UITableView.appearance().separatorStyle = .none
          UITableViewCell.appearance().backgroundColor = .none
          UITableView.appearance().backgroundColor = .none
          UITableView.appearance().separatorStyle = .none
          UITableView.appearance().separatorColor = .none
      }
  }
}
