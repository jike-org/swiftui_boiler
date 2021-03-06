//
// Image.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ImageFile: Codable {

    public var _id: Int?
    public var uuid: String?
    public var category: String?
    public var name: String?
    public var _description: String?
    public var originalFilename: String?
    public var filePath: String?
    public var fileDisk: String?
    public var fileUrl: String?
    public var optimizedFilePath: String?
    public var optimizedFileDisk: String?
    public var optimizedFileUrl: String?
    public var thumbnailPath: String?
    public var thumbnailDisk: String?
    public var thumbnailUrl: String?
    public var fileSizeBytes: String?
    public var height: Int?
    public var width: Int?
    public var type: String?
    public var uploadedByUserId: Int?
    public var deletedAt: String?
    public var createdAt: String?
    public var updatedAt: String?

    public init(_id: Int?, uuid: String?, category: String?, name: String?, _description: String?, originalFilename: String?, filePath: String?, fileDisk: String?, fileUrl: String?, optimizedFilePath: String?, optimizedFileDisk: String?, optimizedFileUrl: String?, thumbnailPath: String?, thumbnailDisk: String?, thumbnailUrl: String?, fileSizeBytes: String?, height: Int?, width: Int?, type: String?, uploadedByUserId: Int?, deletedAt: String?, createdAt: String?, updatedAt: String?) {
        self._id = _id
        self.uuid = uuid
        self.category = category
        self.name = name
        self._description = _description
        self.originalFilename = originalFilename
        self.filePath = filePath
        self.fileDisk = fileDisk
        self.fileUrl = fileUrl
        self.optimizedFilePath = optimizedFilePath
        self.optimizedFileDisk = optimizedFileDisk
        self.optimizedFileUrl = optimizedFileUrl
        self.thumbnailPath = thumbnailPath
        self.thumbnailDisk = thumbnailDisk
        self.thumbnailUrl = thumbnailUrl
        self.fileSizeBytes = fileSizeBytes
        self.height = height
        self.width = width
        self.type = type
        self.uploadedByUserId = uploadedByUserId
        self.deletedAt = deletedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case uuid
        case category
        case name
        case _description = "description"
        case originalFilename = "original_filename"
        case filePath = "file_path"
        case fileDisk = "file_disk"
        case fileUrl = "file_url"
        case optimizedFilePath = "optimized_file_path"
        case optimizedFileDisk = "optimized_file_disk"
        case optimizedFileUrl = "optimized_file_url"
        case thumbnailPath = "thumbnail_path"
        case thumbnailDisk = "thumbnail_disk"
        case thumbnailUrl = "thumbnail_url"
        case fileSizeBytes = "file_size_bytes"
        case height
        case width
        case type
        case uploadedByUserId = "uploaded_by_user_id"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }


}

