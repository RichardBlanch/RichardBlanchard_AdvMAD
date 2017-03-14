//
//  AddToView.swift
//  GainnTrainn
//
//  Created by Rich Blanchard on 3/12/17.
//  Copyright © 2017 Rich. All rights reserved.
//

import UIKit

public  enum AddToViewButtonTapped:String {
    case journal = "Journal"
    case calendar = "Calendar"
    case cancel = "Cancel"
}
 protocol AddToViewDelegate: NSObjectProtocol {
   
    func addToViewButtonTapped(fromButton button:AddToViewButtonTapped)
}
class AddToView: UIView {
    private var animator:UIDynamicAnimator!
    private var snapBehavior:UISnapBehavior!
    private let pointToSnapTo = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    weak var delegate:AddToViewDelegate?
    
    @IBAction func addToJournal(_ sender: RemoveAll) {
        delegate?.addToViewButtonTapped(fromButton: AddToViewButtonTapped.journal)
    }
    @IBAction func addToCalendar(_ sender: RemoveAll) {
        delegate?.addToViewButtonTapped(fromButton: AddToViewButtonTapped.calendar)
    }
    @IBAction func userHitCancel(_ sender: UIButton){
        delegate?.addToViewButtonTapped(fromButton: AddToViewButtonTapped.cancel)
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        self.frame = CGRect(x: pointToSnapTo.x, y: pointToSnapTo.y, width: 300, height: 300)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    private func setUp() {
        
        if let viewToAdd = Bundle.main.loadNibNamed("AddToView", owner: self, options: nil)?[0] as? UIView {
            animator = UIDynamicAnimator()
            addSubview(viewToAdd)
            snapBehavior = UISnapBehavior(item: self, snapTo: pointToSnapTo)
            snapBehavior.damping = 0.8
            animator.addBehavior(snapBehavior)
        }
       
    }
    func fallOffScreen(completionHandler:@escaping (Void)->Void) {
        let gravity = UIGravityBehavior(items: [self])
        animator.removeBehavior(snapBehavior)
        animator.addBehavior(gravity)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {  
            completionHandler()

        }
    }

}
