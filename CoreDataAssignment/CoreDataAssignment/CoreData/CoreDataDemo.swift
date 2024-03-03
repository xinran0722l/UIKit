//
//  CoreDataDemo.swift
//  CoreDataAssignment
//
//  Created by Xinran Yu on 2/29/24.
//

import UIKit
import CoreData

public class CoreDataDemo: UIViewController {
    var container: CoreDataStack!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        guard container != nil else {
            fatalError("This view needs a persistent container.")
        }
    }
    
    func saveData() {
        deleteData()
        // create Landlord instance

        let landlord1 = Landlord(context: container.managedContext)
        landlord1.firstName = "John"
        landlord1.lastName = "Doe"
        landlord1.propertyOwnershipId = UUID()
        landlord1.rentalIncome = NSDecimalNumber(decimal: 5000.00)
        
        let landlord2 = Landlord(context: container.managedContext)
        landlord2.firstName = "Jane"
        landlord2.lastName = "Smith"
        landlord2.propertyOwnershipId = UUID()
        landlord2.rentalIncome = NSDecimalNumber(decimal: 3000.00)
        
        let apartment1 = createApartment(unitNumber: 101, numRooms: 3, monthlyRent: 1500.00, landlord: landlord1)
        let apartment2 = createApartment(unitNumber: 102, numRooms: 2, monthlyRent: 1200.00, landlord: landlord1)
        _ = createApartment(unitNumber: 103, numRooms: 1, monthlyRent: 800.00, landlord: landlord2)
        createTenant(firstName: "Alice", lastName: "Wonderland", leaseTermLength: 12, apartment: apartment1)
        createTenant(firstName: "Bob", lastName: "Builder", leaseTermLength: 12, apartment: apartment1)
        createTenant(firstName: "Charlie", lastName: "Chocolate", leaseTermLength: 12, apartment: apartment1)
        createTenant(firstName: "Dora", lastName: "Explorer", leaseTermLength: 12, apartment: apartment2)
        createTenant(firstName: "Eve", lastName: "Online", leaseTermLength: 12, apartment: apartment2)
        container.saveContext()
    }
    
    private func createApartment(unitNumber: Int, numRooms: Int, monthlyRent: Double, landlord: Landlord) -> Apartment {
            let apartment = Apartment(context: container.managedContext)
            apartment.unitNumber = Int16(unitNumber)
            apartment.numRooms = Int16(numRooms)
            apartment.monthlyRent = NSDecimalNumber(value: monthlyRent)
            apartment.ownedBy = landlord
            return apartment
    }
    
    private func createTenant(firstName: String, lastName: String, leaseTermLength: Int, apartment: Apartment) {
            let tenant = Tenant(context: container.managedContext)
            tenant.firstName = firstName
            tenant.lastName = lastName
            tenant.leaseTermLength = Int16(leaseTermLength)
            tenant.rentersInsuranceId = UUID()
            tenant.leases = apartment
    }
    
//    func getData() {
//        print("\n\n--------------- CoreData getData() ---------------\n")
//        let landlordRequest = Landlord.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: #keyPath(Landlord.firstName), ascending: false)
//        landlordRequest.sortDescriptors = [sortDescriptor]
//        do {
//            let landlords = try container.managedContext.fetch(landlordRequest)
//            let landlord = landlords[0]
//            guard let apartments = landlord.owns?.allObjects as? [Apartment] else { return }
//            for apartment in apartments {
//                let unitNumber = apartment.unitNumber
//                print("  Apartment Unit: \(unitNumber), Rent: \(apartment.monthlyRent ?? 0.00)")
//                
//                guard let tenants = apartment.houses?.allObjects as? [Tenant] else { return }
//                if tenants.isEmpty{
//                    print("No tenants")
//                    } else {
//                        for tenant in tenants{
//                            guard let tenantName = tenant.firstName, let tenantLastName = tenant.lastName else {return}
//                            print("    Tenant: \(tenantName) \(tenantLastName)")
//                    }
//                }
//            }
//        } catch {
//            print("Could not load data", error)
//        }
//    }
    func getData(completion: @escaping ([Landlord]) -> Void) {
            guard let context = container?.managedContext else { return }
            let request: NSFetchRequest<Landlord> = Landlord.fetchRequest()
            do {
                let landlords = try context.fetch(request)
                completion(landlords)
            } catch {
                print("Failed to fetch landlords: \(error)")
                completion([])
        }
    }
    
    func deleteData() {
        let entities = ["Landlord","Apartment","Tenant"]
        
        for entity in entities {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
            
            do {
                let fetchedObjects = try container.managedContext.fetch(fetchRequest)
                
                for object in fetchedObjects {
                    if let managedObject = object as? NSManagedObject {
                        container.managedContext.delete(managedObject)
                    }
                }
                try container.managedContext.save()
            } catch {
                print(error)
            }
        }

    }
}
