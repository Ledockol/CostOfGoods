//
//  CandlesTableViewController.swift
//  cost of goods
//
//  Created by Андрей Беседин on 03.08.2025.
//
import UIKit

// Протокол для уведомления об обновлении свечи
protocol CandleUpdatedDelegate: AnyObject {
    func candleDidUpdate(_ candle: Candle)
}

class CandlesTableViewController: UITableViewController, CandleUpdatedDelegate {
    
    // Массив свечей
    var candles: [Candle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CandleCell")

    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        //Првоерка нажатия кнопки
        print("Кнопка + нажата")
        addCandle()
    }
    // Обработка нажатия кнопки добавления
    @objc func addCandle() {
        let newCandle = Candle(
            name: "",
            type: "",
            waxVolume: 0,
            waxPricePerKg: 0,
            aromaPercentage: 0,
            aromaPricePer100g: 0,
            containerType: "",
            containerPrice: 0,
            wickType: "",
            wickPrice: 0,
            additionalCosts: 0,
            comment: ""
        )
        
        // Проверка создания свечи
        print("Создана новая свеча: \(newCandle.name), ID: \(newCandle.id)")
        
        // Добавляем в массив
        candles.append(newCandle)
        
        // Обновляем таблицу
        tableView.reloadData()
        
        //Переход на страницу редактирования созданной свечи
        performSegue(withIdentifier: "editCandleSegue", sender: newCandle)
    }
    // Добавляем обработку нажатия на ячейку
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Получаем выбранную свечу
            let selectedCandle = candles[indexPath.row]
            // Выполняем переход к детальной информации
            performSegue(withIdentifier: "showDetailSegue", sender: selectedCandle)
        }
        
    // Переход
    // Модифицируем prepare(for:sender:)
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetailSegue" {
                guard let destination = segue.destination as? CandleDetailViewController,
                      let candle = sender as? Candle else {
                    return
                }
                destination.candle = candle
            } else if segue.identifier == "editCandleSegue" {
                // Существующая логика для редактирования
                guard let destination = segue.destination as? EditCandleViewController,
                      let candle = sender as? Candle else {
                    print("Ошибка передачи данных")
                    return
                }
                destination.delegate = self
                destination.candle = candle
            }
        }
        
    
    // Метод протокола для обновления свечи
       func candleDidUpdate(_ candle: Candle) {
           print("Получено обновление свечи: \(candle.name), ID: \(candle.id)")
           
           if let index = candles.firstIndex(where: { $0.id == candle.id }) {
               print("Найден индекс: \(index)")
               candles[index] = candle
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           } else {
               print("Не удалось найти свечу для обновления")
           }
       }
    
    
    
    // Методы таблицы
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CandleCell",
            for: indexPath
        )
        
        let candle = candles[indexPath.row]
        cell.textLabel?.text = "\(candle.name) | \(candle.aromaVolume)г | \(candle.waxVolume)г | \(candle.cost)₽"
        return cell
    }
    // Дополнительно: обработка удаления ячейки
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                candles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    
    
    
    }
