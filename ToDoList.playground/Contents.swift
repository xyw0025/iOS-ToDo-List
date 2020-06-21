//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import SideMenu
import Firebase
import FirebaseFirestore
import Foundation

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()


//let db = Firestore.firestore()
//db.collection("Tasks").getDocuments { (query, eeror) -> Void in
//    if let query = query {
//        for task in query.documents {
//            print(task.data())
//           
//        }
//    }
//    else {print("..")}
//}
print("..")

