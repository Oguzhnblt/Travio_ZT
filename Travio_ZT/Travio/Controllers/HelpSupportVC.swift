import UIKit
import SnapKit

class HelpSupportVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var selectedIndexPath: IndexPath?
    private var isExpanded: Bool = false
    
    private lazy var cellReuseIdentifier = "cell"
    private lazy var expandedHeight: CGFloat = 150
    private lazy var collapsedHeight: CGFloat = 45
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 85, left: 0, bottom: 250, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HelpSupportCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .white
        headerLabel.text = "Help&Support"
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        
        return headerLabel
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor(named: "background")
        headerLabel.text = "FAQ"
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 24)
        
        return headerLabel
    }()
    
    private lazy var helpSuppportItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "content")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    @objc private func backButtonTapped() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "background")
        self.view.addSubviews(backButton,headerLabel,helpSuppportItemView, contentLabel)
        
        backButton.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(headerLabel.snp.left)
            make.left.equalToSuperview()
        })
        
        headerLabel.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(72)
        })
        
        contentLabel.snp.makeConstraints({make in
            make.top.equalTo(helpSuppportItemView.snp.top).offset(44)
            make.left.equalToSuperview().offset(24)
        })
        helpSuppportItemView.snp.makeConstraints({make in
            
            make.top.bottom.equalToSuperview().offset(165)
            make.left.right.equalToSuperview()
        })
        
        helpSuppportItemView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! HelpSupportCell
        
        let item = helpItems[indexPath.item]
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.subtitle
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let isExpanded = selectedIndexPath == indexPath
        return CGSize(width: collectionView.bounds.width - 16, height: isExpanded  ? expandedHeight : collapsedHeight)
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
}
 

#if DEBUG
import SwiftUI

@available(iOS 13 , *)
struct HelpSupportVC_Preview: PreviewProvider {
    static var previews: some View {
        HelpSupportVC().showPreview()
    }
}
#endif
