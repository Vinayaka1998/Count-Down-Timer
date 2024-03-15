//
//  CountDownView.swift
//  DaysCountDownApp
//
//  Created by Vinayaka on 14/03/24.
//

import UIKit

class CountDownView: UIView {
    
    //MARK: - Outlets.
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var countDownView: UIView!
    @IBOutlet weak var countDownLabel: UILabel!
    
    //MARK: - Initializers.
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
        setUpUI()
    }
    
    //MARK: - Method to load the nib.
    private func loadViewFromNib() {
        let bundle = Bundle.init(for: self.classForCoder)
        bundle.loadNibNamed("CountDownView", owner: self, options: nil)
        self.mainView.frame = bounds
        self.addSubview(self.mainView)
    }
    
    //MARK: - Any UI related setup can be handled in this method.
    func setUpUI() {
        countDownLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        countDownLabel.textColor = UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 1.0)
        countDownLabel.layer.shadowColor = UIColor.black.cgColor
        countDownLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        countDownLabel.layer.shadowOpacity = 1
        countDownLabel.layer.shadowRadius = 0
        self.countDownView.layer.cornerRadius = 4.0
        self.countDownView.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
}
