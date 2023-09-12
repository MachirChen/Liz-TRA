//
//  CoreDataManager.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/11.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Liz-TRA")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchTrainScheduleData() -> [TrainSchedule] {
        let context = persistentContainer.viewContext
        do {
            let trainSchedule = try context.fetch(TrainSchedule.fetchRequest())
            return trainSchedule
        } catch let fetchErr {
            print("Failed to fetch train schedule data:", fetchErr)
            return []
        }
    }
    
    func saveTrainScheduleData() {
        let context = persistentContainer.viewContext
        let trainScheduleData = TrainSchedule(context: context)
        trainScheduleData.departureStation = "南港"
        trainScheduleData.arrivalStation = "臺北"
        trainScheduleData.departureId = "0980"
        trainScheduleData.arrivalId = "1000"
        trainScheduleData.date = Date.getCurrentDate()
        trainScheduleData.time = Date.getCurrentTime()
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save train schedule data:", saveErr)
        }
    }
    
    func deletaData() {
        let context = persistentContainer.viewContext
        let trainScheduleData = try! context.fetch(TrainSchedule.fetchRequest())
        context.delete(trainScheduleData[0])
        do {
            try context.save()
        } catch let deleteErr {
            print("Failed to delete train schedule data:", deleteErr)
        }
    }
    
    func editTrainScheduleData(departureStation: String, arrivalStation: String) {
        let context = persistentContainer.viewContext
        let trainScheduleData = try! context.fetch(TrainSchedule.fetchRequest())
        trainScheduleData[0].departureStation = departureStation
        trainScheduleData[0].arrivalStation = arrivalStation
        print(trainScheduleData)
//        trainScheduleData[0].dateAndTime = Date.getCurrentDate()
        do {
            try context.save()
        } catch let editErr {
            print("Failed to edit train schedule data:", editErr)
        }
    }
    
    func editTrainScheduleData(departureStation: String, departureId: String, arrivalStation: String, arrivalId: String) {
        let context = persistentContainer.viewContext
        let trainScheduleData = try! context.fetch(TrainSchedule.fetchRequest())
        trainScheduleData[0].departureStation = departureStation
        trainScheduleData[0].arrivalStation = arrivalStation
        trainScheduleData[0].departureId = departureId
        trainScheduleData[0].arrivalId = arrivalId
        do {
            try context.save()
        } catch let editErr {
            print("Failed to edit train schedule data:", editErr)
        }
    }
    
    func changeTrainSchedule(data: TrainSchedule) {
        let context = persistentContainer.viewContext
        var trainScheduleData = try! context.fetch(TrainSchedule.fetchRequest())
        trainScheduleData[0] = data
        do {
            try context.save()
        } catch let editErr {
            print("Failed to edit train schedule data:", editErr)
        }
    }
    
    func editTrainScheduleDate(dateAndTime: String) {
        let context = persistentContainer.viewContext
        let trainScheduleData = try! context.fetch(TrainSchedule.fetchRequest())
        trainScheduleData[0].dateAndTime = dateAndTime
        do {
            try context.save()
        } catch let editErr {
            print("Failed to edit train schedule data:", editErr)
        }
    }
    
    func editTrainSchedule(date: String, time: String) {
        let context = persistentContainer.viewContext
        let trainScheduleData = try! context.fetch(TrainSchedule.fetchRequest())
        trainScheduleData[0].date = date
        trainScheduleData[0].time = time
        do {
            try context.save()
        } catch let editErr {
            print("Failed to edit train schedule data:", editErr)
        }
    }

}
