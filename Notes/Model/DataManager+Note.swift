//
//  DataManager+Note.swift
//  Notes
//
//  Created by Jinwook Huh on 2022/01/21.
//

import CoreData
import Foundation

extension DataManager {
    func createNote(noteItem: NoteItem, completion: (() -> Void)? = nil) {
        mainContext.perform {
            let newNote: NoteEntity = NoteEntity(context: self.mainContext)
            newNote.title = noteItem.title
            newNote.body = noteItem.body
            newNote.lastModified = noteItem.lastModified
            self.saveMainContext()
            completion?()
        }
    }
    
    func fetchFood() -> [NoteItem] {
        var fetchedNoteItems: [NoteItem] = []
        
        mainContext.performAndWait {
            let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
            
            do {
                let noteEntities: [NoteEntity] = try mainContext.fetch(request)
                fetchedNoteItems = noteEntities.map { NoteItem(title: $0.title ?? "", body: $0.body ?? "", lastModified: $0.lastModified) }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return fetchedNoteItems
    }
}
