//
//  ViewController.swift
//  LenskartIOS
//
//  Created by pavithra on 11/12/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var vmMovieDetail: MovieDetailViewModel!
    @IBOutlet weak var tvMovieDetails: UITableView!
    var didBookMarkTappedAtIndex:((_ items:Results?)->())? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    func setupViews() {
        registerTableCell()
    }
    func registerTableCell(){
        let headerNib = UINib.init(nibName: String(describing: MovieDetailTableViewCell.self), bundle: nil)
        self.tvMovieDetails.register(headerNib, forCellReuseIdentifier: "MovieDetailTableViewCell")
        tvMovieDetails.dataSource = self
        tvMovieDetails.delegate = self
    }
}
