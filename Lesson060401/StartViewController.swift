//
//  StartViewController.swift
//  Lesson060401
//
//  Created by Бектур Кадыркулов on 8/4/23.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {

     var productAmount = 0
     var basketproduct = 0
    
    
    private var product:[Product] = [Product(name: "Pepperoni", price: "400", image: "1"),Product(name: "Mushrooms", price: "450", image: "2"),Product(name: "Burger", price: "200", image: "3")]
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.minimumLineSpacing = 20
      //  layout.itemSize = CGSize(width: 250, height: 100)
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemGreen
        view.showsVerticalScrollIndicator = false
        view.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseld)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
     lazy var basketButton:UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "basket.fill"),for: .normal)
        view.backgroundColor = .systemRed
        view.setTitleColor(.white, for: .normal)
        view.tintColor = .white
        view.setTitle("\(productAmount)", for: .normal)
         view.addTarget(self, action: #selector(goToCart), for: .touchUpInside)
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    setupSubView()
       
    }
    
    func addProduct (){
        productAmount += 1
        basketButton.setTitle("\(productAmount)", for: .normal)
    }
    @objc func goToCart() {
         
           
            guard let tabBarController = self.tabBarController else { return }
            guard let cartVC = tabBarController.viewControllers?[2] as? DetailViewController else { return }
            cartVC.food = basketproduct
            tabBarController.selectedIndex = 2
    }
    
    
    private func setupSubView(){
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        view.addSubview(basketButton)
        basketButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(70)
            make.centerX.equalToSuperview()
        }
        
    }


}

extension StartViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseld, for: indexPath) as! CustomCell
        cell.fill(product: product[indexPath.row])
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }

}

extension StartViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      //  if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width - 30 , height: 200)
       // }else{
        //    return CGSize(width: 300, height: 200)
       // }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(), animated: false)
    }
}
extension StartViewController:CellAction {
    func didProductChose(index: Int) {
        productAmount += 1
        basketButton.setTitle("\(productAmount)", for: .normal)
    }
    
    
}
