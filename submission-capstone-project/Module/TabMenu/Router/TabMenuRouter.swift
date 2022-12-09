//
//  TabMenuRouter.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI
import Core
import Restaurant
import Favourite

class TabMenuRouter {

  func makeRestaurantView() -> some View {
    let restaurantUseCase: Interactor<
      Any,
        [RestaurantDomainModel],
        GetRestaurantsRepository<
          GetRestaurantLocalDataSource,
            GetRestaurantsRemoteDataSource,
            RestaurantsTransformer>
    > = Injection.init().provideRestaurants()
    
    let presenter = GetListPresenter(useCase: restaurantUseCase)
    
    return RestaurantView(presenter: presenter)
  }
  
  func makeFavouriteView() -> some View {
    
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
    
    let presenter = FavouritesPresenter(
      storeUseCase: storeFavouriteUseCase,
      getUseCase: favouritesUseCase,
      getbyIdUseCase: favouriteUseCase,
      deleteUseCase: deleteFavouriteUseCase)
    
    return FavouriteView(presenter: presenter)
  }
  
  func makeProfileView() -> some View {
    return ProfileView()
  }
  
}
