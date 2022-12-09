//
//  TabMenuPresenter.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 20/11/22.
//

import SwiftUI

class TabMenuPresenter {
  private let router = TabMenuRouter()
  
  func linkRestaurantBuilder<Content: View>(
    title: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationView {
      router.makeRestaurantView().navigationTitle(Text(title))
    }.tabItem {
      content()
    }
  }
  
  func linkFavouriteBuilder<Content: View>(
    title: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationView {
      router.makeFavouriteView().navigationTitle(Text(title))
    }.tabItem {
      content()
    }
  }
  
  func linkProfileBuilder<Content: View>(
    title: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationView {
      router.makeProfileView().navigationTitle(Text(title))
    }.tabItem {
      content()
    }
  }
}
