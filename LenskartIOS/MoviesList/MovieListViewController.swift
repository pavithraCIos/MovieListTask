//
//  ViewController.swift
//  LenskartIOS
//
//  Created by pavithra on 15/12/22.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var vmMovieList: MovieListViewModel!
    @IBOutlet weak var tvMovieList: UITableView!
    var lastContentOffset: CGFloat = 0
    var pagecount = 1
    lazy var rcTrending: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action:
                                    #selector(MovieListViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .gray
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    func setupViews() {
        self.tvMovieList.refreshControl = self.rcTrending
        registerTableCell()
        self.vmMovieList.fetchMovieList(pageCount: pagecount)
    }
    func registerTableCell(){
        let headerNib = UINib.init(nibName: String(describing: MovieListTableViewCell.self), bundle: nil)
        self.tvMovieList.register(headerNib, forCellReuseIdentifier: "MovieListTableViewCell")
        tvMovieList.dataSource = self
        tvMovieList.delegate = self
    }
    //MARK:- Refresh control
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if AppDelegate.shared.network.isAvailable {
            self.rcTrending.beginRefreshing()
            self.vmMovieList.fetchMovieList(pageCount: 1)
            self.rcTrending.endRefreshing()
        }
    }
}
