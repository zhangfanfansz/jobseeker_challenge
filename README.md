# README

## Rails Layout Template

* Ruby Version: 3.0.4

## Set Up Step:
  1. check ruby version
  2. config `database.yml`
  3. bundle install
  4. run `rails db:create db:migrate db:seed`

## Start Step
* start rails server 

* **JobMatchService**
1. The data has been imported through the seed file
2. To generate the job match results report, open the Rails console and run `JobMatchService.new.generate_report`
3. The report will be generated and saved as `job_match_report.csv` in the root directory of your project

* **Rspec Test**
* run `rspec`, the coverage report will be generated in `coverage/index.html`

## Note
  Performance solution for large data input:
  * To apply the performance solution, you need to substitute the query within the function `job_match_results` by uncommenting the `PERFORMANCE SOLUTION` query
  * Example usage: `JobMatchService.new(per_page: 60, last_seen_jobseeker_id: 1, last_seen_job_id: 1).generate_report`
  * Explanation: This solution implements a pagination mechanism by setting the anchors last_seen_jobseeker_id and last_seen_job_id
  * The query execution time is tied to the value of `per_page` rather than the total size of the table

  Setup Consideration:
  For better performance, the service function should be processed by using a Sidekiq worker. However, this feature has not been implemented in favor of a simpler project setup
