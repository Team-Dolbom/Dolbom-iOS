import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.tabBar.unselectedItemTintColor = UIColor(named: "TabbarColor")
        self.tabBar.tintColor = UIColor(named: "Main")
    }
    func setupTabBar() {
        let communityView = CommunityViewController()
        let offerView = OfferViewController()
        let myPageView = MyPageViewController()

        let communityImage = UIImage(named: "offer")?.withRenderingMode(.alwaysTemplate)

        communityView.tabBarItem = UITabBarItem(title: "커뮤니티", image: UIImage(systemName: "house.fill")
                                                , tag: 0)
        offerView.tabBarItem = UITabBarItem(title: "제안", image: communityImage, tag: 1)
        myPageView.tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage(systemName: "person.crop.circle.fill"),
            tag: 2
            )
        self.viewControllers = [communityView, offerView, myPageView]
    }
}
