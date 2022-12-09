//
//  TabMenuView.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI


struct TabMenuView: View {
    var presenter: TabMenuPresenter
    var body: some View {
        TabView {
          self.presenter.linkRestaurantBuilder(title: "Restaurant", content: {
            Image(systemName: "house")
            Text("Restaurant")
          })
          self.presenter.linkFavouriteBuilder(title: "Favourites", content: {
            Image(systemName: "heart.fill")
            Text("Favourites")
          })
          self.presenter.linkProfileBuilder(title: "Profile", content: {
            Image(systemName: "person.circle")
            Text("Profile")
          })
        }.onAppear {
          let tabBarAppearance = UITabBarAppearance()
          tabBarAppearance.configureWithOpaqueBackground()
          if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
          }
          let navigationBarAppearance = UINavigationBarAppearance()
          navigationBarAppearance.configureWithOpaqueBackground()
        }
    }
}

