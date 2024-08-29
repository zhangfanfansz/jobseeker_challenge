require 'csv'
class JobMatchService
  attr_accessor :per_page, :last_seen_jobseeker_id, :last_seen_job_id

  def initialize(options = {})
    @per_page = options[:per_page] || 50
    @last_seen_jobseeker_id = options[:last_seen_jobseeker_id]
    @last_seen_job_id = options[:last_seen_job_id]
  end

  def job_match_results
    # # PERFORMANCE SOLUTION for large data: pagination is partially done by utilizing last_seen_jobseeker_id and last_seen_job_id
    # raise ArgumentError, "Both last_seen_jobseeker_id and last_seen_job_id must be provided." if @last_seen_jobseeker_id.nil? || @last_seen_job_id.nil?
    # query = <<-SQL
    #   SELECT 
    #     match1.taggable_id AS jobseeker_id,
    #     match1.taggable_name AS jobseeker_name,
    #     match2.taggable_id AS job_id,
    #     match2.taggable_name AS job_title,
    #     COUNT(DISTINCT match1.tag_id) AS shared_attributes,
    #     ROUND(
    #       (COUNT(DISTINCT match1.tag_id) / 
    #       NULLIF((SELECT COUNT(DISTINCT tag_id) 
    #         FROM tag_matches 
    #         WHERE taggable_id = match2.taggable_id AND taggable_type = 'Job'),0)::numeric) * 100, 0
    #       ) AS match_rate
    #   FROM
    #     tag_matches match1
    #   JOIN 
    #     tag_matches match2
    #     ON match1.tag_id = match2.tag_id
    #   WHERE 
    #     match1.taggable_type = 'Jobseeker'
    #     AND match2.taggable_type = 'Job'
    #     AND (match1.taggable_id = #{last_seen_jobseeker_id} AND match2.taggable_id > #{last_seen_job_id})
    #     OR (match1.taggable_id > #{last_seen_jobseeker_id})
    #   GROUP BY 
    #     match1.taggable_id, match2.taggable_id, match1.taggable_name, match2.taggable_name
    #   ORDER BY 
    #     match1.taggable_id, match_rate DESC,match2.taggable_id ASC
    #   LIMIT #{per_page};
    # SQL

    # solution: add the name column in the table tag_matches, performance is better but need to maintain data consistency
    query = <<-SQL
      SELECT 
        match1.taggable_id AS jobseeker_id,
        match1.taggable_name AS jobseeker_name,
        match2.taggable_id AS job_id,
        match2.taggable_name AS job_title,
        COUNT(DISTINCT match1.tag_id) AS shared_attributes,
        ROUND(
          (COUNT(DISTINCT match1.tag_id) / 
          (SELECT COUNT(DISTINCT tag_id) 
            FROM tag_matches 
            WHERE taggable_id = match2.taggable_id AND taggable_type = 'Job')::numeric) * 100, 0
        ) AS match_rate
      FROM
        tag_matches match1
      JOIN 
        tag_matches match2
        ON match1.tag_id = match2.tag_id
      WHERE 
        match1.taggable_type = 'Jobseeker'
        AND match2.taggable_type = 'Job'
      GROUP BY 
        match1.taggable_id, match2.taggable_id, match1.taggable_name, match2.taggable_name
      ORDER BY 
        match1.taggable_id, match_rate DESC,match2.taggable_id ASC
      LIMIT #{per_page};
    SQL
    
    results = ActiveRecord::Base.connection.exec_query(query)
  end

  # report generation can be moved to a worker
  def generate_report
    begin
      CSV.open("job_match_report.csv", "w") do |csv|
        csv << ["jobseeker_id", "jobseeker_name", "job_id", "job_title", "matching_skill_count", "matching_skill_percent"]
  
        job_match_results.each do |row|
          begin
            match_rate = row['match_rate'].to_f.round.to_i
            csv << row.values_at('jobseeker_id', 'jobseeker_name', 'job_id', 'job_title', 'shared_attributes') + [match_rate]
          rescue => e
            Rails.logger.debug "Failed to write row: #{row.inspect}. Error: #{e.message}"
            next
          end
        end
      end
  
      Rails.logger.debug "Report generated successfully: job_match_report.csv"
    rescue => e
      Rails.logger.debug "Failed to generate report. Error: #{e.message}"
    end
  end
end
