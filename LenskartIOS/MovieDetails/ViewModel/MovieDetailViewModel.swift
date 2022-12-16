//
//  MovieListViewModel.swift
//  LenskartIOS
//
//  Created by pavithra on 11/12/22.
//

import Foundation

/// `MovieListViewModel`, MovieListViewModelController's view model
final class MovieDetailViewModel: NSObject {
    /// The viewController this view model is associated with.
    @IBOutlet weak var viewController: MovieDetailViewController!
    var results:[Results]? = nil
   
    var bookmarkedMovieList:[Results]? = [] {
        didSet {
            guard (self.viewController.tvMovieDetails != nil) else{return}
            self.viewController.tvMovieDetails.reloadData()
            }
        }
}

