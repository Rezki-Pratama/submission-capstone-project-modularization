//
//  TabMenuView.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI
import Common


struct TabMenuView: View {
    var presenter: TabMenuPresenter
    var body: some View {
        TabView {
          self.presenter.linkRestaurantBuilder(title: "restaurant".localized(identifier: "rezki-pratama.submission-capstone-project"), content: {
            Image(systemName: "house")
            Text("restaurant".localized(identifier: "rezki-pratama.submission-capstone-project"))
          })
          self.presenter.linkFavouriteBuilder(title: "favourites".localized(identifier: "rezki-pratama.submission-capstone-project"), content: {
            Image(systemName: "heart.fill")
            Text("favourites".localized(identifier: "rezki-pratama.submission-capstone-project"))
          })
          self.presenter.linkProfileBuilder(title: "profile".localized(identifier: "rezki-pratama.submission-capstone-project"), content: {
            Image(systemName: "person.circle")
            Text("profile".localized(identifier: "rezki-pratama.submission-capstone-project"))
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

