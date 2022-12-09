//
//  Injection.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import Foundation
import RealmSwift
import Core
import Restaurant
import Favourite

final class Injection: NSObject {
  
  private let realm = try! Realm(configuration: Realm.Configuration())
  
  func provideRestaurants<U: UseCase>() -> U where U.Request == Any, U.Response == [RestaurantDomainModel] {
      
      let locale = GetRestaurantLocalDataSource(realm: realm)
      
      let remote = GetRestaurantsRemoteDataSource()
      
      let mapper = RestaurantsTransformer()
      
      let repository = GetRestaurantsRepository(
          localDataSource: locale,
          remoteDataSource: remote,
          mapper: mapper)
      
      return Interactor(repository: repository) as! U
  }
  
  func provideRestaurant<U: UseCase>() -> U where U.Request == Any, U.Response == RestaurantDomainModel {
    
    let remote = GetRestaurantRemoteDataSource()
    
    let mapper = RestaurantTransformer()
    
    let repository = GetRestaurantRepository(
      remoteDataSource: remote,
      mapper: mapper
    )
    
    return Interactor(repository: repository) as! U
  }
  
  func provideStoreRestaurant<U: UseCase>() -> U where U.Request == [String: Any], U.Response == String {
    
    let remote = StoreRestaurantRemoteDataSource()
    
    let repository = StoreRestaurantRepository(
      remoteDataSource: remote
    )
    
    return Interactor(repository: repository) as! U
  }
  
  func provideFavourites<U: UseCase>() -> U where U.Request == Any, U.Response == [RestaurantDomainModel] {
    
    let local = GetFavouriteLocalDataSource(realm: realm)
    
    let mapper = FavouritesTransformer()
    
    let repository = GetFavouritesRepository(
      localDataSource: local,
      mapper: mapper
    )
    
    return Interactor(repository: repository) as! U
  }
  
  func provideFavourite<U: UseCase>() -> U where U.Request == String, U.Response == FavouriteModuleEntity {
    
    let local = GetFavouriteLocalDataSource(realm: realm)
    
    let repository = GetFavouriteRepository(
      localDataSource: local
    )
    
    return Interactor(repository: repository) as! U
  }
  
  func provideStoreFavourite<U: UseCase>() -> U where U.Request == RestaurantDomainModel, U.Response == Bool {
    
    let local = GetFavouriteLocalDataSource(realm: realm)
    
    let mapper = FavouriteTransformer()
    
    let repository = StoreFavouriteRepository(
      localDataSource: local,
      mapper: mapper
    )
    
    return Interactor(repository: repository) as! U
  }
  
  func provideDeleteFavourite<U: UseCase>() -> U where U.Request == FavouriteModuleEntity, U.Response == Bool {
    
    let local = GetFavouriteLocalDataSource(realm: realm)
    
    let repository = DeleteFavouriteRepository(
      localDataSource: local
    )
    
    return Interactor(repository: repository) as! U
  }
  
  func providerTabMenuPresenter() -> TabMenuPresenter {
    return TabMenuPresenter()
  }
  
}
