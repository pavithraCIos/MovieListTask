//
//  MovieListViewController+TableView.swift
//  LenskartIOS
//
//  Created by pavithra on 11/12/22.
//

import Foundation
import UIKit


extension MovieDetailViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell", for: indexPath) as? MovieDetailTableViewCell else { return MovieDetailTableViewCell() }
        guard let result = self.vmMovieDetail.results?[indexPath.row] else {
            return MovieDetailTableViewCell()
        }
        cell.configureCellWith(items: result)
        cell.checkBookMark(items: self.vmMovieDetail.bookmarkedMovieList, id:result.id ?? 0)
        cell.didBookMarkTappedAtIndex = { items in
            if let itemValue = items{
                if let index = self.vmMovieDetail.bookmarkedMovieList?.firstIndex(where: { $0.id == itemValue.id }) {
                    self.vmMovieDetail.bookmarkedMovieList?.remove(at: index)
                }else {
                    self.vmMovieDetail.bookmarkedMovieList?.append(itemValue)
                }
                self.didBookMarkTappedAtIndex?(itemValue)
            }
        }
        cell.contentView.backgroundColor = .lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
