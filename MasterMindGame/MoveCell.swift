//
//  MoveCell.swift
//  MasterMindGame
//
//  Created by Master on 09.12.2022.
//

import UIKit
import MasterMindEngine

class MoveCell: UITableViewCell{

    @IBOutlet weak var itemRequestCollection: UICollectionView!
    @IBOutlet weak var itemResponceCollection: UICollectionView!
    @IBOutlet weak var movesLabel: UILabel!
    
    var cellRequestDelegate = MoveCellRequestDelegate(row: RowRequest(items: []))
    var cellResponceDelegate = MoveCellResponceDelegate(row: RowResponce(items: []))
    
    func confView(requestRow: RowRequest, responceRow: RowResponce, movesLeft: Int) {
        movesLabel.text = "\(movesLeft)"
        
        cellRequestDelegate = MoveCellRequestDelegate(row: requestRow)
        cellResponceDelegate = MoveCellResponceDelegate(row: responceRow)
        
        configure(collection: itemRequestCollection, delegate: cellRequestDelegate, datasource: cellRequestDelegate)
        configure(collection: itemResponceCollection, delegate: cellResponceDelegate, datasource: cellResponceDelegate)
        
    }
    
    private func configure(collection: UICollectionView,delegate: UICollectionViewDelegate, datasource: UICollectionViewDataSource) {
        collection.delegate = delegate
        collection.dataSource = datasource
        collection.register(ItemCell.self, forCellWithReuseIdentifier: "ItemCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.reloadData()
    }

}

class MoveCellRequestDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var row: RowRequest
    
    init(row: RowRequest) {
        self.row = row
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        row.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell ?? ItemCell()
        cell.label.backgroundColor = row.items[indexPath.row].color
        return cell
    }

}

class MoveCellResponceDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var row: RowResponce
    
    init(row: RowResponce) {
        self.row = row
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        row.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell ?? ItemCell()
        //cell.label.text = "item"
        //cell.label.textColor = .red
        cell.label.backgroundColor = row.items[indexPath.row].color
        return cell
    }

}
