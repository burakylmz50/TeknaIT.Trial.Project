# TeknaIT Trial Project

## Setup
* Close Xcode
* Open a terminal window, and $ cd into your project directory.
* Run $ pod install
* You may require to run $ pod update
* $ open TeknaTrialProject.xcworkspace and build.

## Code structure

#### Random color function
```swift
extension UIColor {
    class var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
```
##### Custom UI Transitions
```swift
extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //INFO: use UINavigationControllerOperation.push or UINavigationControllerOperation.pop to detect the 'direction' of the navigation
        
        class FadeAnimation: NSObject, UIViewControllerAnimatedTransitioning {
            func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
                return 0.5
            }
            
            func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
                let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
                if let vc = toViewController {
                    transitionContext.finalFrame(for: vc)
                    transitionContext.containerView.addSubview(vc.view)
                    vc.view.alpha = 0.0
                    UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                                   animations: {
                                    vc.view.alpha = 1.0
                    },
                                   completion: { finished in
                                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    })
                } else {
                    NSLog("Oops! Something went wrong! 'ToView' controller is nill")
                }
            }
        }
        
        return FadeAnimation()
    }
}

```
## Design pattern
MVC design pattern is used for this project.

## Third Party Libraries
* <a href="https://github.com/SnapKit/SnapKit">SnapKit</a>

## Design
The designs were made on **Figma** depend on the template you sent.

## Requirements
* iOS 13.4+
* Xcode 11.0+
* Swift 4.0+

## Author
If you wish to contact me, email at: byilmaz50@hotmail.com

## License
TeknaIT is available under the MIT license. See the LICENSE file for more info.

