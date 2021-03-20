//
//  VocabularyTVC.swift
//  EnglishPlus
//
//  Created by Max on 2019/6/7.
//  Copyright © 2019 MAX. All rights reserved.
//

import UIKit
import AVFoundation

class VocabularyTVC: UITableViewController{

    var myList = [String]()
    var wordList = [String]()
    var subTitleList = [String]()
    var meanList = [String]()
    
    var passedData:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVocabularyData(passedData!)

    }

    
    func getVocabularyData(_ wordNumber:String) -> Void {
        do{
            let filePath = Bundle.main.path(forResource: "vocabulary", ofType: "txt")
            let url = URL(fileURLWithPath: filePath!)
            let downloadData = try Data(contentsOf: url)
            let json = try JSON(data: downloadData)
            
            wordList = [String]()
            subTitleList = [String]()
            meanList = [String]()
            
            if let vocabularyData = json[wordNumber][0].array{
                for data in vocabularyData{
                    wordList.append(data.stringValue)
                }
            }
            
            if let vocabularyData = json[wordNumber][1].array{
                for data in vocabularyData{
                    subTitleList.append(data.stringValue)
                }
            }
            
            if let vocabularyData = json[wordNumber][2].array{
                for data in vocabularyData{
                    meanList.append(data.stringValue)
                }
            }
        }catch{
            print("error")
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wordList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VocabularyCell else {
            
            return UITableViewCell()
        }
        cell.titleLabel.text = wordList[indexPath.row]
        cell.subTitleLabel.text = subTitleList[indexPath.row]
        cell.meanLabel.text = meanList[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myText = wordList[indexPath[1]]
        let utterance = AVSpeechUtterance(string: myText)
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
