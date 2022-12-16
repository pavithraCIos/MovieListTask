//
//  MovieListViewModel.swift
//  LenskartIOS
//
//  Created by pavithra on 15/12/22.
//

import Foundation

/// `MovieListViewModel`, MovieListViewModelController's view model
final class MovieListViewModel: NSObject {
    /// The viewController this view model is associated with.
    @IBOutlet weak var viewController: MovieListViewController!
    var results:[Results]? = nil
    var isStyleCardsLoading: Bool = false
    var total_count = 0
    var bookmarkedMovieList:[Results]? = [] {
        didSet {
            self.viewController.tvMovieList.reloadData()
        }
    }
}

extension MovieListViewModel{
    func fetchMovieList(pageCount: Int ,isShowIndicator show:Bool = true, isPagination paging:Bool = false) {
        if !paging {
            self.viewController.pagecount = 1
        }
        AppDelegate.shared.showLoader()
        self.isStyleCardsLoading = true
        APIManager.getMovieList(offset: pageCount, params: []) { (results, total_count) in
            AppDelegate.shared.hideLoader()
            self.isStyleCardsLoading = false
            if self.viewController.pagecount == 1 {
                self.results = results?.results
            } else if self.viewController.pagecount > 1 {
                self.results?.append(contentsOf: results?.results ?? [])
            }
            self.total_count = total_count
            self.viewController.tvMovieList.reloadData()
        }
    }
}
