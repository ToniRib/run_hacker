require "csv"

namespace :db do
  desc "Create location models from CSV files"
  task :import_locations_from_csv => :environment do
    CSV.foreach("./vendor/assets/csvs/zip_code_database.csv", headers: true) do |row|
      Location.create(city:    row[:primary_city],
                      state:   row[:state],
                      zipcode: row[:zip])
    end
  end
end
