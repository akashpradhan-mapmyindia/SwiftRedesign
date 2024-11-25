//
//  OpenHoursSelectionViewController.swift
//  SwiftRedesign
//
//  Created by rento on 05/11/24.
//

import UIKit
import FittedSheets

class WeekDays: Hashable {
    
    var day: WeekDaysEnum
    var isSelected: Bool
    
    init(day: WeekDaysEnum, isSelected: Bool) {
        self.day = day
        self.isSelected = isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(day)
    }
    
    static func == (lhs: WeekDays, rhs: WeekDays) -> Bool {
        return lhs.day == rhs.day
    }
}

class SelectTime: Hashable {
    
    var timeType: SelectTimeType
    var isSelected: Bool
    
    init(timeType: SelectTimeType, isSelected: Bool) {
        self.timeType = timeType
        self.isSelected = isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(timeType)
    }
    
    static func == (lhs: SelectTime, rhs: SelectTime) -> Bool {
        return lhs.timeType == rhs.timeType
    }
}

class CustomTime: Hashable {
    
    var fromTime: Time
    var toTime: Time
    var id: UUID
    
    init(fromTime: Time, toTime: Time) {
        self.fromTime = fromTime
        self.toTime = toTime
        self.id = UUID()
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: CustomTime, rhs: CustomTime) -> Bool {
        return lhs.toTime == rhs.toTime && lhs.fromTime == rhs.toTime
    }
}

enum OpenHoursHashable: Hashable {
    
    case weekDays(WeekDays)
    case selectTime(SelectTime)
    case customTime(CustomTime)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .selectTime(let timeType):
            return hasher.combine(timeType)
        case .weekDays(let day):
            return hasher.combine(day)
        case .customTime(let customTime):
            return hasher.combine(customTime)
        }
    }
    
    static func == (lhs: OpenHoursHashable, rhs: OpenHoursHashable) -> Bool {
        switch (lhs, rhs) {
        case (.selectTime(let lhs), .selectTime(let rhs)):
            return lhs == rhs
        case (.weekDays(let lhs), .weekDays(let rhs)):
            return lhs == rhs
        case (.customTime(let lhs), .customTime(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}

enum SelectTimeType: String {
    case open24Hours = "Open 24 hours"
    case close = "Close"
    case customTime = "Custom Time"
}

enum WeekDaysEnum: String {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    
    static func allDays() -> [WeekDaysEnum] {
        return [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    }
    
    var abbreviation: String {
        switch self {
        case .sunday, .saturday:
            return "S"
        case .monday:
            return "M"
        case .tuesday, .thursday:
            return "T"
        case .wednesday:
            return "W"
        case .friday:
            return "F"
        }
    }
}

struct Time: Equatable {
    
    enum MeridiemType: String {
        case am = "AM"
        case pm = "PM"
    }
    
    var hours: Int
    var minutes: Int
    var meridiemType: MeridiemType
    
    func attributedTime(hourMinuteAttributes: [NSAttributedString.Key : Any], meridiemAttributes: [NSAttributedString.Key : Any]) -> NSMutableAttributedString {
        let hourMinuteAttrStr = NSMutableAttributedString(string: "\(hours):\(minutes < 10 ? ("0" + String(minutes)) : String(minutes))", attributes: hourMinuteAttributes)
        let meridiemAttrStr = NSAttributedString(string: " \(meridiemType.rawValue)", attributes: meridiemAttributes)
        hourMinuteAttrStr.append(meridiemAttrStr)
        return hourMinuteAttrStr
    }
    
    func time() -> String {
        return "\(hours):\(minutes < 10 ? ("0" + String(minutes)) : String(minutes))" + " \(meridiemType.rawValue)"
    }
    
    mutating func addTime(time: Time) {
        minutes += time.minutes
        if minutes > 59 {
            minutes -= 60
            hours += 1
        }
        
        hours += time.hours
        if hours > 12 {
            hours -= 12
            meridiemType = meridiemType == .am ? .pm : .am
        }
    }
    
    static func toTime(stringTime: String) -> Time? {
        if isValidTimeFormat(stringTime: stringTime) {
            let split1 = stringTime.split(separator: " ")
            let split2 = split1[0].split(separator: ":")
            let regexPattern = "^am$"
            let regex = try! NSRegularExpression(pattern: regexPattern, options: [.caseInsensitive])

            var meridiem: MeridiemType
            let meridiemStr = String(split1[1])
            let range = NSRange(location: 0, length: meridiemStr.utf16.count)

            if regex.firstMatch(in: meridiemStr, options: [], range: range) != nil {
                meridiem = .am
            } else {
                meridiem = .pm
            }
            return Time(hours: Int(String(split2[0]))!, minutes: Int(String(split2[1]))!, meridiemType: meridiem)
        }else {
            return nil
        }
    }
    
    static func isValidTimeFormat(stringTime: String) -> Bool {
        let pattern = "^([0-9]|1[0-2]):[0-5][0-9] (?i:AM|PM)$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: stringTime.utf16.count)
        return regex?.firstMatch(in: stringTime, options: [], range: range) != nil
    }
    
    static func isIntervalValid(lhs: Time, rhs: Time) -> Bool {
        if lhs.meridiemType == .am && rhs.meridiemType == .pm {
            return true
        }else if lhs.meridiemType == .pm && rhs.meridiemType == .am {
            return false
        }else if lhs.hours <= rhs.hours {
            if lhs.hours < rhs.hours {
                return true
            }else if lhs.hours == rhs.hours {
                if lhs.minutes < rhs.minutes {
                    return true
                }
            }
        }
        return false
    }
    
    static func == (lhs: Time, rhs: Time) -> Bool {
        return ((lhs.minutes == rhs.minutes) && (lhs.hours == rhs.hours) && (lhs.meridiemType == rhs.meridiemType))
    }
}

class OpenHoursSelectionViewController: UIViewController {
    
    enum SupplimentaryItemKind: String {
        case header = "headerKind"
    }
    
    var topBar: UIView!
    var weekDaysCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, OpenHoursHashable>!
    var sections: [[OpenHoursHashable]] = []
    var timeRangePickerView: TimeRangePickerView!
    var timePickerTimes: [String] = []
    var timePickerSheet: SheetViewController?
    var addHoursBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        topBar = UIView()
        topBar.layer.shadowRadius = 1
        topBar.layer.shadowColor = UIColor(hex: "#0000004D").cgColor
        topBar.layer.shadowOpacity = 0.7
        topBar.layer.shadowOffset = .zero
        topBar.backgroundColor = .white
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let titleLbl = UILabel()
        titleLbl.text = "Select days & time"
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
        titleLbl.textAlignment = .center
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            titleLbl.centerXAnchor.constraint(equalTo: topBar.centerXAnchor)
        ])
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalTo: topBar.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backBtn.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            backBtn.heightAnchor.constraint(equalToConstant: 40),
            backBtn.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        setUpWeekDaysData()
        setUpTimePickerData()
        setUpWeekCollectionView()
        setAddHoursBtn()
        setUpCancelDoneBtn()
        setUpCustomTimeView()
        
        dataSource = makeDataSource()
        applyInitialSnapshot()
    }
    
    func setUpTimePickerData() {
        var startTime = Time(hours: 0, minutes: 1, meridiemType: .am)
        while startTime.meridiemType != .pm || (startTime.hours <= 11 && startTime.minutes <= 59) {
            timePickerTimes.append(startTime.time())
            startTime.addTime(time: .init(hours: 0, minutes: 5, meridiemType: startTime.meridiemType))
        }
    }
    
    func setUpWeekDaysData() {
        var section: [OpenHoursHashable] = []
        WeekDaysEnum.allDays().forEach { day in
            section.append(.weekDays(.init(day: day, isSelected: false)))
        }
        sections.append(section)
        section = []
        
        section.append(.selectTime(.init(timeType: .open24Hours, isSelected: true)))
        section.append(.selectTime(.init(timeType: .close, isSelected: false)))
        section.append(.selectTime(.init(timeType: .customTime, isSelected: false)))
        
        sections.append(section)
        section = []
        
        sections.append(section)
    }
    
    func setUpWeekCollectionView() {
        
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            if section == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(50), heightDimension: .absolute(50))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                var group: NSCollectionLayoutGroup!
                if layoutEnvironment.traitCollection.verticalSizeClass == .regular {
                    group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                }else {
                    let landscapeGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                    group = NSCollectionLayoutGroup.horizontal(layoutSize: landscapeGroupSize, subitem: item, count: self.sections[0].count)
                    group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 20)
                    group.interItemSpacing = .fixed(20)
                }
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing =  20
                section.contentInsets = .init(top: 20, leading: 15, bottom: 20, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                return section
            }else if section == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(113), heightDimension: .absolute(33))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing =  20
                section.contentInsets = .init(top: 10, leading: 15, bottom: 10, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SupplimentaryItemKind.header.rawValue, alignment: .top)
                
                section.boundarySupplementaryItems = [header]
                return section
            }else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                section.contentInsets = .init(top: 15, leading: 15, bottom: 15, trailing: 15)
                return section
            }
        }
        
        weekDaysCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        weekDaysCollectionView.delegate = self
        weekDaysCollectionView.register(OpenHoursWeekDayCell.self, forCellWithReuseIdentifier: OpenHoursWeekDayCell.identifer)
        weekDaysCollectionView.register(OpenHoursSelectTimeCell.self, forCellWithReuseIdentifier: OpenHoursSelectTimeCell.identifier)
        weekDaysCollectionView.register(OpenHoursCustomTimeCell.self, forCellWithReuseIdentifier: OpenHoursCustomTimeCell.identifier)
        weekDaysCollectionView.register(CollectionViewSupplementaryItemTextView.self, forSupplementaryViewOfKind: SupplimentaryItemKind.header.rawValue, withReuseIdentifier: CollectionViewSupplementaryItemTextView.identifier)
        weekDaysCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weekDaysCollectionView)
        
        NSLayoutConstraint.activate([
            weekDaysCollectionView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 5),
            weekDaysCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weekDaysCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Int, OpenHoursHashable> {
        let dataSource = UICollectionViewDiffableDataSource<Int, OpenHoursHashable>(collectionView: weekDaysCollectionView) { collectionView, indexPath, itemIdentifier in
            let cellData = self.sections[indexPath.section][indexPath.row]
            switch cellData {
            case .weekDays(let weekDay):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OpenHoursWeekDayCell.identifer, for: indexPath) as? OpenHoursWeekDayCell else {return UICollectionViewCell()}
                cell.setUpUI(for: weekDay)
                return cell
            case .selectTime(let timeType):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OpenHoursSelectTimeCell.identifier, for: indexPath) as? OpenHoursSelectTimeCell else {return UICollectionViewCell()}
                cell.setUpUI(for: timeType)
                return cell
            case .customTime(let customTime):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OpenHoursCustomTimeCell.identifier, for: indexPath) as?  OpenHoursCustomTimeCell else {return UICollectionViewCell()}
                cell.setUpUI(with: customTime)
                return cell
            }
        }
        return dataSource
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, OpenHoursHashable>()
        for (index, section) in sections.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems(section, toSection: index)
        }
        dataSource.apply(snapshot)
        
        dataSource.supplementaryViewProvider = {collectionView, kind, indexPath in
            if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSupplementaryItemTextView.identifier, for: indexPath) as! CollectionViewSupplementaryItemTextView
                cell.setUpUI(for: "Select Time")
                return cell
            }
            return nil
        }
    }
    
    func setAddHoursBtn() {
        addHoursBtn = UIButton(type: .system)
        let attributedTitle = NSAttributedString(string: "Add Hours", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue, NSAttributedString.Key.underlineColor : UIColor(hex: "#339E82"), NSAttributedString.Key.font : UIFont.sfProText.semiBold.ofSize(size: .regular)])
        addHoursBtn.setAttributedTitle(attributedTitle, for: .normal)
        addHoursBtn.addTarget(self, action: #selector(self.showCustomTimeView), for: .touchUpInside)
        addHoursBtn.setTitleColor(.init(hex: "#339E82"), for: .normal)
        addHoursBtn.layer.borderColor = UIColor.white.cgColor
        addHoursBtn.backgroundColor = .white
        addHoursBtn.isHidden = true
        addHoursBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addHoursBtn)
        
        NSLayoutConstraint.activate([
            addHoursBtn.topAnchor.constraint(equalTo: self.weekDaysCollectionView.bottomAnchor),
            addHoursBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addHoursBtn.heightAnchor.constraint(equalToConstant: 44),
            addHoursBtn.widthAnchor.constraint(equalToConstant: 165)
        ])
    }
    
    func setUpCancelDoneBtn() {
        let cancelBtn = UIButton(type: .system)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.layer.cornerRadius = 8
        cancelBtn.titleLabel?.font = .sfProText.semiBold.ofSize(size: .regular)
        cancelBtn.backgroundColor = .white
        cancelBtn.setTitleColor(.black, for: .normal)
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.borderColor = UIColor(hex: "#339E82").cgColor
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let doneBtn = UIButton(type: .system)
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.titleLabel?.font = .sfProText.semiBold.ofSize(size: .regular)
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.backgroundColor = .init(hex: "#339E82")
        doneBtn.layer.cornerRadius = 8
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [cancelBtn, doneBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: addHoursBtn.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34)
        ])
    }
    
    func setUpCustomTimeView() {
        timeRangePickerView = TimeRangePickerView()
        timeRangePickerView.setUpUI()
        timeRangePickerView.finishedBtn.addTarget(self, action: #selector(self.timePicked), for: .touchUpInside)
        timeRangePickerView.fromPicker.dataSource = self
        timeRangePickerView.fromPicker.delegate = self
        timeRangePickerView.toPicker.dataSource = self
        timeRangePickerView.toPicker.delegate = self
        
        var sheetOptions = SheetOptions()
        sheetOptions.useInlineMode = true
        sheetOptions.pullBarHeight = 0
        sheetOptions.transitionAnimationOptions = .curveLinear
        
        let sheet = SheetViewController(controller: timeRangePickerView, sizes: [.intrinsic], options: sheetOptions)
        sheet.contentBackgroundColor = .clear
        sheet.dismissOnPull = false
        sheet.dismissOnOverlayTap = false
        sheet.allowGestureThroughOverlay = false
        sheet.allowPullingPastMaxHeight = false
        sheet.allowPullingPastMinHeight = false
        sheet.overlayColor = .init(hex: "#00000066")
        
        self.timePickerSheet = sheet
    }
    
    @objc func timePicked() {
        let index1 = timeRangePickerView.fromPicker.selectedRow(inComponent: 0)
        let index2 = timeRangePickerView.toPicker.selectedRow(inComponent: 0)
        let fTime = Time.toTime(stringTime: self.timePickerTimes[index1])
        let tTime = Time.toTime(stringTime: self.timePickerTimes[index2])
        
        if fTime != nil, tTime != nil {
            if Time.isIntervalValid(lhs: fTime!, rhs: tTime!) {
                appendToCustomTimes(fromTime: fTime!, toTime: tTime!)
                self.timePickerSheet?.attemptDismiss(animated: true)
            }else {
                let alert = UIAlertController(title: "Invalid Time Interval", message: "Opening time cannot be more than or equal to closing time.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                present(alert, animated: true)
            }
        }
    }
    
    func appendToCustomTimes(fromTime: Time, toTime: Time) {
        sections[2].append(.customTime(CustomTime(fromTime: fromTime, toTime: toTime)))
        
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, OpenHoursHashable>()
        for (index, section) in sections.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems(section, toSection: index)
        }
        dataSource.apply(snapshot)
    }
    
    @objc func showCustomTimeView() {
        timePickerSheet?.animateIn(to: view, in: self)
    }
    
    override func viewDidLayoutSubviews() {
        let shadowSize: CGFloat = 20
        let contactRect = CGRect(x: -shadowSize, y: topBar.frame.height - (shadowSize * 0.4), width: topBar.frame.width + shadowSize * 2, height: 10)
        topBar.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
    }
    
    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension OpenHoursSelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellData = sections[indexPath.section][indexPath.row]
        var cellsToReload: [OpenHoursHashable] = []
        switch cellData {
        case .weekDays(let day):
            day.isSelected = !day.isSelected
            cellsToReload.append(cellData)
        case .selectTime(let timeType):
            if !timeType.isSelected {
                if timeType.timeType == .customTime {
                    addHoursBtn.isHidden = false
                    applySnapshot()
                }else {
                    addHoursBtn.isHidden = true
                    var snapshot = dataSource.snapshot()
                    snapshot.deleteSections([2])
                    dataSource.apply(snapshot)
                }
                timeType.isSelected = true
                cellsToReload.append(cellData)
                sections[indexPath.section].forEach { cData in
                    switch cData {
                    case .selectTime(let tType):
                        if tType != timeType && tType.isSelected {
                            tType.isSelected = false
                            cellsToReload.append(cData)
                        }
                    default:
                        break
                    }
                }
            }
        default:
            return
        }
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems(cellsToReload)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension OpenHoursSelectionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timePickerTimes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timePickerTimes[row]
    }
}
