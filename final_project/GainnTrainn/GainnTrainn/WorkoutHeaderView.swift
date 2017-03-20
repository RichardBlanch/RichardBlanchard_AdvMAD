//
//  WorkoutHeaderView.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 2/20/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit


class WorkoutHeaderView: UIView {
    private enum kTag:Int {
        case label = 100
        case image = 200
    }
    @IBOutlet weak private var workoutCreatorLabel:UILabel!
    var workoutCreatorText:String! {
        didSet {
          workoutCreatorLabel.text = workoutCreatorText
        }
    }
    
    var imageForWorkout:UIImage! {
        didSet {
            if let imageView = self.viewWithTag(kTag.image.rawValue) as? UIImageView {
                imageView.contentMode = .scaleAspectFill
                imageView.image = imageForWorkout
            }
        }
    }
    

    override init(frame: CGRect) {
        
        super.init(frame: frame)
         fromNib()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 

}
extension UIView {
    
    @discardableResult   // 1
    func fromNib<T : UIView>() -> T? {   // 2
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {    // 3
            // xib not loaded, or it's top view is of the wrong type
            return nil
        }
        self.addSubview(view)     // 4
        return view   // 7
    }
}
