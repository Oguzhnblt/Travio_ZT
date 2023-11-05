import UIKit
import SnapKit

class HelpSupportVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var selectedIndexPath: IndexPath?
    private var isExpanded: Bool = false
    
    private lazy var cellReuseIdentifier = "cell"
    private lazy var expandedHeight: CGFloat = 160
    private lazy var collapsedHeight: CGFloat = 55
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HelpSupportCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.text = "Edit Profile"
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        
        return headerLabel
    }()
    
    private lazy var helpSuppportItemView: UIView = {
        let view = UIView()
        view.backgroundColor = .content
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .background
        self.view.addSubviews(helpSuppportItemView, headerLabel)
        
        helpSuppportItemView.snp.makeConstraints({make in
        
            make.top.bottom.equalToSuperview().offset(125)
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
        return CGSize(width: collectionView.bounds.width - 16, height: indexPath == selectedIndexPath  ? expandedHeight : collapsedHeight)
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
