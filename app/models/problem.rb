class Problem < ApplicationRecord
    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            problem = find_by(id: row["id"]) || new
            problem.attributes = row.to_hash.slice(*updatable_attributes)
            problem.save!
        end
    end
    def self.updatable_attributes
        ["problem", "image_url", "answer", "dummy1", "dummy2", "dummy3"]
    end
end
