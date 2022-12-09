//
//  RestaurantRouter.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI
import Restaurant
import Core
import Favourite

class RestaurantRouter {

  static func makeDetailView(for restaurant: RestaurantDomainModel) -> some View {
    
    let restaurantUseCase: Interactor<
      Any,
      RestaurantDomainModel,
        GetRestaurantRepository<
          GetRestaurantRemoteDataSource,
          RestaurantTransformer>
    > = Injection.init().provideRestaurant()
    
    let storeRestaurantUseCase: Interactor<
      [String: Any],
      String,
      StoreRestaurantRepository<
          StoreRestaurantRemoteDataSource
      >> = Injection.init().provideStoreRestaurant()
    
    let favouritesUseCase: Interactor<
      Any,
      [RestaurantDomainModel],
        GetFavouritesRepository<
          GetFavouriteLocalDataSource,
          FavouritesTransformer>
    > = Injection.init().provideFavourites()
    
    let favouriteUseCase: Interactor<
      String,
      FavouriteModuleEntity,
        GetFavouriteRepository<
          GetFavouriteLocalDataSource>
    > = Injection.init().provideFavourite()
    
    let storeFavouriteUseCase: Interactor<
      RestaurantDomainModel,
      Bool,
        StoreFavouriteRepository<
          GetFavouriteLocalDataSource,
          FavouriteTransformer>
    > = Injection.init().provideStoreFavourite()
    
    let deleteFavouriteUseCase: Interactor<
      FavouriteModuleEntity,
      Bool,
        DeleteFavouriteRepository<
          GetFavouriteLocalDataSource>
    > = Injection.init().provideDeleteFavourite()
    
    let presenter = GetDetailPresenter(useCase: restaurantUseCase)
    
    let storePresenter = StorePresenter(useCase: storeRestaurantUseCase)
    
    let favouritePresenter = FavouritesPresenter(
      storeUseCase: storeFavouriteUseCase,
      getUseCase: favouritesUseCase,
      getbyIdUseCase: favouriteUseCase,
      deleteUseCase: deleteFavouriteUseCase)
    
    return RestaurantDetailView(presenter: presenter, storePresenter: storePresenter, favouritePresenter: favouritePresenter, restaurant: restaurant)
  }
}

