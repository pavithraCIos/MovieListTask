//
//  MovieListViewController+TableView.swift
//  LenskartIOS
//
//  Created by pavithra on 15/12/22.
//

import Foundation
import UIKit


extension MovieListViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vmMovieList.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else { return MovieListTableViewCell() }
        guard let result = self.vmMovieList.results?[indexPath.row] else {
            return MovieListTableViewCell()
        }
        cell.configureCellWith(items: result)
        cell.checkBookMark(items: self.vmMovieList.bookmarkedMovieList, id:result.id ?? 0)
        cell.didBookMarkTappedAtIndex = { items in
            if let itemValue = items{
                
                if let index = self.vmMovieList.bookmarkedMovieList?.firstIndex(where: { $0.id == itemValue.id }) {
                    self.vmMovieList.bookmarkedMovieList?.remove(at: index)
                }else {
                    self.vmMovieList.bookmarkedMovieList?.append(itemValue)
                }
            }
        }
        cell.contentView.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == ((self.vmMovieList.results?.count ?? 0) - 1) {
            if self.pagecount < (self.vmMovieList.total_count)-1 {
                self.pagecount += 1
                self.vmMovieList.isStyleCardsLoading = true
                self.vmMovieList.fetchMovieList(pageCount: pagecount, isShowIndicator: false, isPagination: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "MovieDetails", bundle:nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            if let result = self.vmMovieList.results?[indexPath.row] {
                vc.vmMovieDetail.results = [result]
            }
            vc.vmMovieDetail.bookmarkedMovieList = vmMovieList.bookmarkedMovieList
            vc.didBookMarkTappedAtIndex = { items in
                if let itemValue = items{
                    if let index = self.vmMovieList.bookmarkedMovieList?.firstIndex(where: { $0.id == itemValue.id }) {
                        self.vmMovieList.bookmarkedMovieList?.remove(at: index)
                    }else {
                        self.vmMovieList.bookmarkedMovieList?.append(itemValue)
                    }
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
