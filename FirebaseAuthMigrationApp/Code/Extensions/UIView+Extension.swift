import UIKit

extension UIView {
    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let topConstraint = topAnchor.constraint(equalTo: superview.topAnchor)
            topConstraint.identifier = "top"
            let leadingConstraint = leadingAnchor.constraint(equalTo: superview.leadingAnchor)
            leadingConstraint.identifier = "leading"
            let bottomConstraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            bottomConstraint.identifier = "bottom"
            let trailingConstraint = trailingAnchor.constraint(equalTo: superview.rightAnchor)
            trailingConstraint.identifier = "trailing"
            [leadingConstraint, trailingConstraint, topConstraint, bottomConstraint].forEach { $0.isActive = true }
        }
    }
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, constants insets: UIEdgeInsets = UIEdgeInsets.zero, size: CGSize = CGSize.zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, constants: insets, size: size)
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, constants insets: UIEdgeInsets = UIEdgeInsets.zero, size: CGSize = CGSize.zero) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            let topConstraint = topAnchor.constraint(equalTo: top, constant: insets.top)
            topConstraint.identifier = "top"
            anchors.append(topConstraint)
        }
        
        if let left = left {
            let leftConstraint = leadingAnchor.constraint(equalTo: left, constant: insets.left)
            leftConstraint.identifier = "leading"
            anchors.append(leftConstraint)
        }
        
        if let bottom = bottom {
            let bottomConstraint = bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom)
            bottomConstraint.identifier = "bottom"
            anchors.append(bottomConstraint)
        }
        
        if let right = right {
            let trailingConstraint = rightAnchor.constraint(equalTo: right, constant: -insets.right)
            trailingConstraint.identifier = "trailing"
            anchors.append(trailingConstraint)
        }
        
        if size.width > 0 {
            let widthConstraint = widthAnchor.constraint(equalToConstant: size.width)
            widthConstraint.identifier = "width"
            anchors.append(widthConstraint)
        }
        
        if size.height > 0 {
            let heightConstraint = heightAnchor.constraint(equalToConstant: size.height)
            heightConstraint.identifier = "height"
            anchors.append(heightConstraint)
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            let centerXConstraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
            centerXConstraint.identifier = "centerX"
            centerXConstraint.isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            let centerYConstraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
            centerYConstraint.identifier = "centerY"
            centerYConstraint.isActive = true
        }
    }
    
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
}
