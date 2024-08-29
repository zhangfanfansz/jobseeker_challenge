# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'csv'

# Data Import
Jobseeker.delete_all
Job.delete_all
TagMatch.delete_all
Tag.delete_all

CSV.foreach(Rails.public_path.join('jobseekers.csv'), headers: true) do |row|
  ActiveRecord::Base.transaction do
    job_seeker = Jobseeker.find_or_create_by!(id: row['id'], name: row['name'])
    raise StandardError, "skills can't be blank." if row['skills'].blank?

    skills = row['skills'].split(',').map(&:strip)
    skills.each do |skill|
      tag = Tag.find_or_create_by!(tag_name: skill, tag_code_name: skill.parameterize(separator: '_'))
      TagMatch.create(tag: tag, taggable: job_seeker, taggable_name: job_seeker.name)
    end

  rescue StandardError => e
    p "Error importing job_seeker: #{row.inspect} - #{e.message}"
    raise ActiveRecord::Rollback
  end
end

CSV.foreach(Rails.public_path.join('jobs.csv'), headers: true) do |row|
  ActiveRecord::Base.transaction do
    job = Job.find_or_create_by!(id: row['id'], title: row['title'])
    raise StandardError, "required_skills can't be blank." if row['required_skills'].blank?

    skills = row['required_skills'].split(',').map(&:strip)
    skills.each do |skill|
      tag = Tag.find_or_create_by!(tag_name: skill, tag_code_name: skill.parameterize(separator: '_'))
      TagMatch.create!(tag: tag, taggable: job, taggable_name: job.title)
    end

  rescue StandardError => e
    p "Error importing job: #{row.inspect} - #{e.message}"
    raise ActiveRecord::Rollback
  end
end
