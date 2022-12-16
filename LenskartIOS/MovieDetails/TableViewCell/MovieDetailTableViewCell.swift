//
//  TableViewCell.swift
//  LenskartIOS
//
//  Created by pavithra on 11/12/22.
//

import UIKit
import SDWebImage

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var bookMarkImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOriginalTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblVoting: UILabel!
    
    var didBookMarkTappedAtIndex:((_ items:Results?)->())? = nil
    var movieResults: Results? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCellWith(items: Results){
        setupView()
        movieResults = items
        lblTitle.text = items.title
        lblOriginalTitle.text = items.original_title
        lblOverview.text = items.overview
        lblDate.text =   " \(items.release_date ?? "") "
        lblPopularity.text = " \(items.popularity ?? 0) "
        lblVoting.text = " Voting: \(items.vote_count ?? 0) "
        guard let url:String =  Optional(APIManager.baseImageUrl) else { return }
        largeImage.sd_setImage(with: URL.init(string: url + (items.poster_path ?? "")), completed: { (image, error, type, url) in
        })
    }
    func setupView(){
        lblDate.layer.cornerRadius = 8
        lblDate.clipsToBounds = true
        lblDate.backgroundColor = .lightText
        lblPopularity.layer.cornerRadius = 8
        lblPopularity.backgroundColor = .lightText
        lblPopularity.clipsToBounds = true
        lblVoting.layer.cornerRadius = 8
        lblVoting.backgroundColor = .lightText
        lblVoting.clipsToBounds = true
    }
    @IBAction func bookMarkButtonTapped(_ sender: Any){
        self.didBookMarkTappedAtIndex?(movieResults)
    }
    func checkBookMark(items: [Results]?, id:Int){
        if let _ = items?.firstIndex(where: { $0.id == id }) {
            bookMarkImage.image = UIImage(named: "bookmark_selected")
        }else{
            bookMarkImage.image = UIImage(named: "bookmark_unselected")
        }
    }
}
