//
//  BaseViewController+Gadgets.swift
//  SwiftRedesign
//
//  Created by rento on 24/10/24.
//

import UIKit
import FittedSheets

extension BaseViewController {
    func setUpGadgetsTopUI() {
        if gadgetsHeaderV != nil {
            return
        }
        let headerV = UIView()
        headerV.translatesAutoresizingMaskIntoConstraints = false
        headerV.backgroundColor = .white
        headerV.isHidden = true
        view.addSubview(headerV)
        
        gadgetsHeaderVPortraitCons = [headerV.heightAnchor.constraint(equalToConstant: 85 + viewInsetTop)]
                
        gadgetsHeaderVLandscapeCons = [headerV.heightAnchor.constraint(equalToConstant: 90)]

        NSLayoutConstraint.activate([
            headerV.topAnchor.constraint(equalTo: view.topAnchor),
            headerV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerV.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
        self.gadgetsHeaderV = headerV
        
        let titleLbl = UILabel()
        titleLbl.font = .systemFont(ofSize: 16, weight: .medium)
        titleLbl.text = "My Gadgets"
        titleLbl.textAlignment = .center
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        headerV.addSubview(titleLbl)
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: headerV.centerXAnchor)
        ])
        
        gadgetsHeaderVPortraitCons.append(contentsOf: [            titleLbl.topAnchor.constraint(equalTo: headerV.safeAreaLayoutGuide.topAnchor, constant: 10)])
        gadgetsHeaderVLandscapeCons.append(contentsOf: [            titleLbl.topAnchor.constraint(equalTo: headerV.safeAreaLayoutGuide.topAnchor, constant: 15)])
        
        let backArrow = UIButton(type: .system)
        backArrow.setImage(UIImage(systemName: "chevron.backward")!, for: .normal)
        backArrow.contentMode = .scaleAspectFit
        backArrow.translatesAutoresizingMaskIntoConstraints = false
        backArrow.addTarget(self, action: #selector(self.gadgetsBckBtnPressed), for: .touchUpInside)
        headerV.addSubview(backArrow)
        
        NSLayoutConstraint.activate([
            backArrow.leadingAnchor.constraint(equalTo: headerV.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backArrow.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            backArrow.heightAnchor.constraint(equalToConstant: 30),
            backArrow.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        let filterBtn = UIButton(type: .system)
        filterBtn.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        filterBtn.contentMode = .scaleAspectFit
        filterBtn.translatesAutoresizingMaskIntoConstraints = false
        headerV.addSubview(filterBtn)
        gadgetsFilterBtn = filterBtn
        
        NSLayoutConstraint.activate([
            filterBtn.trailingAnchor.constraint(equalTo: headerV.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            filterBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            filterBtn.heightAnchor.constraint(equalToConstant: 20),
            filterBtn.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        let searchBtn = UIButton(type: .system)
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.contentMode = .scaleAspectFit
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        headerV.addSubview(searchBtn)
        gadgetsSearchBtn = searchBtn
        
        NSLayoutConstraint.activate([
            searchBtn.centerYAnchor.constraint(equalTo: filterBtn.centerYAnchor),
            searchBtn.trailingAnchor.constraint(equalTo: filterBtn.leadingAnchor, constant: -30),
            searchBtn.heightAnchor.constraint(equalToConstant: 20),
            searchBtn.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        headerV.addSubview(divider)
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 15),
            divider.leadingAnchor.constraint(equalTo: headerV.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: headerV.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.2)
        ])
        
        setGadgetsSegmentView()
        setGadgetsMovingStateView()
        setUpNewGadgetUI()
        
        if traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.activate(gadgetsHeaderVPortraitCons)
        }else {
            NSLayoutConstraint.activate(gadgetsHeaderVLandscapeCons)
        }
        
    }
    
    func setGadgetsSegmentView() {
        let segmentControl = UISegmentedControl()
        segmentControl.insertSegment(withTitle: "Gadgets", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "New Gadget", at: 1, animated: false)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentTintColor = UIColor(hex: "#339E82")
        segmentControl.addTarget(self, action: #selector(self.segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        gadgetsHeaderV!.addSubview(segmentControl)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        self.gadgetsViewSegmentControl = segmentControl
        
        NSLayoutConstraint.activate([
            segmentControl.bottomAnchor.constraint(equalTo: gadgetsHeaderV!.bottomAnchor, constant: -5),
            segmentControl.leadingAnchor.constraint(equalTo: gadgetsHeaderV!.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            segmentControl.trailingAnchor.constraint(equalTo: gadgetsHeaderV!.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            segmentControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sheet?.animateIn(to: view, in: self)
            gadgetsSetSheetSize()
            gadgetsSearchBtn?.isHidden = false
            gadgetsFilterBtn?.isHidden = false
            newGadgetView?.isHidden = true
            gadgetsStatusNextBtn?.isHidden = false
        }else {
            sheet?.attemptDismiss(animated: true)
            gadgetsStatusNextBtn?.isHidden = true
            newGadgetView?.isHidden = false
            gadgetsSearchBtn?.isHidden = true
            gadgetsFilterBtn?.isHidden = true
        }
    }

    func setUpNewGadgetUI() {
        let newGadgetView = NewGadgetView()
        newGadgetView.delegate = self
        newGadgetView.translatesAutoresizingMaskIntoConstraints = false
        newGadgetView.isHidden = true
        view.addSubview(newGadgetView)
        self.newGadgetView = newGadgetView
        
        NSLayoutConstraint.activate([
            newGadgetView.topAnchor.constraint(equalTo: gadgetsHeaderV!.bottomAnchor),
            newGadgetView.leadingAnchor.constraint(equalTo: gadgetsHeaderV!.leadingAnchor),
            newGadgetView.trailingAnchor.constraint(equalTo: gadgetsHeaderV!.trailingAnchor),
            newGadgetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setGadgetsMovingStateView() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .absolute(30))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(10), top: .fixed(0), trailing: .fixed(10), bottom: .fixed(0))

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .absolute(30))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 50)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let gadgetsStatusCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        gadgetsStatusCollectionView.alwaysBounceVertical = false
        gadgetsStatusCollectionView.alwaysBounceHorizontal = true
        gadgetsStatusCollectionView.translatesAutoresizingMaskIntoConstraints = false
        gadgetsStatusCollectionView.register(GadgetsStatusCell.self, forCellWithReuseIdentifier: GadgetsStatusCell.identifier)
        gadgetsStatusCollectionView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        gadgetsStatusCollectionView.isHidden = true
        view.addSubview(gadgetsStatusCollectionView)
        GadgetsHandler.shared.setCollectionViewDelegate(collectionView: gadgetsStatusCollectionView)
        GadgetsHandler.shared.makeDataSource(gadgetsStatusCollectionView: gadgetsStatusCollectionView)
        GadgetsHandler.shared.applyInitialSnapshot(states: [.init(state: .caution, count: 3), .init(state: .idle), .init(state: .moving), .init(state: .stopped)])
        
        NSLayoutConstraint.activate([
            gadgetsStatusCollectionView.topAnchor.constraint(equalTo: gadgetsHeaderV!.bottomAnchor),
            gadgetsStatusCollectionView.leadingAnchor.constraint(equalTo: gadgetsHeaderV!.leadingAnchor),
            gadgetsStatusCollectionView.trailingAnchor.constraint(equalTo: gadgetsHeaderV!.trailingAnchor),
            gadgetsStatusCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.gadgetsStatusCollectionView = gadgetsStatusCollectionView
        
        let nextBtn = UIButton(type: .system)
        nextBtn.setImage(UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        nextBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        nextBtn.tintColor = .black
        nextBtn.addTarget(self, action: #selector(self.gadgetsStatusNextBtnPressed(_:)), for: .touchUpInside)
        nextBtn.isHidden = true
        view.addSubview(nextBtn)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        self.gadgetsStatusNextBtn = nextBtn
        
        NSLayoutConstraint.activate([
            nextBtn.trailingAnchor.constraint(equalTo: gadgetsStatusCollectionView.safeAreaLayoutGuide.trailingAnchor),
            nextBtn.centerYAnchor.constraint(equalTo: gadgetsStatusCollectionView.centerYAnchor),
            nextBtn.heightAnchor.constraint(equalToConstant: 50),
            nextBtn.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func gadgetsStatusNextBtnPressed(_ sender: UIButton) {
        
    }
    
    @objc func gadgetsBckBtnPressed() {
        sheet?.attemptDismiss(animated: true)
        newGadgetView?.isHidden = true
        removeGadgetsTopView()
    }
    
    func removeGadgetsTopView() {
        gadgetsStatusNextBtn?.isHidden = true
        gadgetsHeaderV?.isHidden = true
        gadgetsStatusCollectionView?.isHidden = true
    }

    func showGadgetsTopView() {
        gadgetsViewSegmentControl?.selectedSegmentIndex = 0
        gadgetsStatusNextBtn?.isHidden = false
        gadgetsSearchBtn?.isHidden = false
        gadgetsFilterBtn?.isHidden = false
        gadgetsHeaderV?.isHidden = false
        gadgetsStatusCollectionView?.isHidden = false
    }
    
    @objc func setUpGadgetsUI() {
        showGadgetsTopView()
        
        var sheetOptions = SheetOptions()
        sheetOptions.pullBarHeight = 0
        sheetOptions.useInlineMode = true
        sheetOptions.transitionAnimationOptions = .curveLinear
        
        let gadgetsVC = MyGadgetsVC()
        sheet = showSheetController(options: sheetOptions, controller: gadgetsVC, sheetSizes: [], from: self, in: view)
        sheet?.handleScrollView(gadgetsVC.gadgetTblView)
        gadgetsSetSheetSize()
    }
    
    func gadgetsSetSheetSize() {
        if self.traitCollection.verticalSizeClass == .regular {
            sheet?.sizes = [.percent(0.25), .percent(0.9)]
            DispatchQueue.main.async {
                if self.sheet?.currentSize == .percent(1.0) {
                    self.sheet?.resize(to: .percent(0.9))
                } else if self.sheet?.currentSize == .percent(0.16){
                    self.sheet?.resize(to: .percent(0.25))
                } else {
                    self.sheet?.resize(to: .percent(0.25))
                }
            }
        }else{
            sheet?.sizes = [.percent(0.16), .percent(1.0)]
            DispatchQueue.main.async {
                if self.sheet?.currentSize == .percent(0.9) {
                    self.sheet?.resize(to: .percent(1.0))
                } else if self.sheet?.currentSize == .percent(0.25) {
                    self.sheet?.resize(to: .percent(0.16))
                } else {
                    self.sheet?.resize(to: .percent(0.16))
                }
            }
        }
    }
}

extension BaseViewController: NewGadgetViewDelegate {
    func addNewGadgetBtnClicked() {
        
    }
    
    func buyNowBtnClicked() {
        
    }
    
    func callSupportBtnClicked() {
        
    }
    
    func writeToUseBtnClicked() {
        
    }
}
