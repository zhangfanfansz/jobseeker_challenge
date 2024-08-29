# frozen_string_literal: true

require 'rails_helper'
require 'csv'

RSpec.describe JobMatchService, type: :service do
  before(:all) do
    @tag1 = create(:tag)
    @tag2 = create(:tag)
    @jobseeker1 = create(:jobseeker)
    @jobseeker2 = create(:jobseeker)
    @job1 = create(:job)
    @job2 = create(:job)
  end

  describe '#job_match_results' do
    let(:service) { described_class.new }

    it 'executes the query and returns results sort by jobseeker_id' do
      tag_match1 = create(:tag_match, tag: @tag2, taggable: @jobseeker2, taggable_name: @jobseeker2.name)
      tag_match2 = create(:tag_match, tag: @tag1, taggable: @jobseeker1, taggable_name: @jobseeker1.name)
      tag_match3 = create(:tag_match, tag: @tag2, taggable: @job2, taggable_name: @job2.title)
      tag_match4 = create(:tag_match, tag: @tag1, taggable: @job1, taggable_name: @job1.title)
      results = service.job_match_results
      expect(results.length).to eq 2
      expect(results.rows.first).to include(
        @jobseeker1.id,
        tag_match2.taggable_name,
        @job1.id,
        tag_match4.taggable_name,
        1,
        100
      )

      expect(results.rows.last).to include(
        @jobseeker2.id,
        tag_match1.taggable_name,
        @job2.id,
        tag_match3.taggable_name,
        1,
        100
      )
    end

    it 'executes the query and returns results sort by percentage of matching skills in descending order' do
      tag_match1 = create(:tag_match, tag: @tag1, taggable: @jobseeker1, taggable_name: @jobseeker1.name)
      tag_match2 = create(:tag_match, tag: @tag2, taggable: @jobseeker1, taggable_name: @jobseeker1.name)

      new_tag = create(:tag)
      tag_match3 = create(:tag_match, tag: @tag2, taggable: @job2, taggable_name: @job2.title)
      tag_match4 = create(:tag_match, tag: new_tag, taggable: @job2, taggable_name: @job2.title)
      tag_match5 = create(:tag_match, tag: @tag2, taggable: @job1, taggable_name: @job1.title)
      tag_match6 = create(:tag_match, tag: @tag1, taggable: @job1, taggable_name: @job1.title)

      results = service.job_match_results
      expect(results.length).to eq 2
      expect(results.rows.first).to include(
        @jobseeker1.id,
        tag_match1.taggable_name,
        @job1.id,
        tag_match5.taggable_name,
        2,
        100
      )

      expect(results.rows.last).to include(
        @jobseeker1.id,
        tag_match1.taggable_name,
        @job2.id,
        tag_match3.taggable_name,
        1,
        50
      )
    end

    it 'executes the query and returns results sort by job ID in ascending order if matching skill percentages are the same' do
      tag_match1 = create(:tag_match, tag: @tag2, taggable: @jobseeker1, taggable_name: @jobseeker1.name)
      tag_match2 = create(:tag_match, tag: @tag1, taggable: @jobseeker1, taggable_name: @jobseeker1.name)

      tag_match3 = create(:tag_match, tag: @tag2, taggable: @job2, taggable_name: @job2.title)
      tag_match4 = create(:tag_match, tag: @tag1, taggable: @job1, taggable_name: @job1.title)

      results = service.job_match_results
      expect(results.length).to eq 2
      expect(results.rows.first).to include(
        @jobseeker1.id,
        tag_match1.taggable_name,
        @job1.id,
        tag_match4.taggable_name,
        1,
        100
      )

      expect(results.rows.last).to include(
        @jobseeker1.id,
        tag_match1.taggable_name,
        @job2.id,
        tag_match3.taggable_name,
        1,
        100
      )
    end
  end

  describe '#generate_report' do
    let(:service) { described_class.new }

    before do
      allow(service).to receive(:job_match_results).and_return(
        [
          { 'jobseeker_id' => 1, 'jobseeker_name' => 'testA', 'job_id' => 10, 'job_title' => 'Developer', 'shared_attributes' => 3, 'match_rate' => 75 },
          { 'jobseeker_id' => 2, 'jobseeker_name' => 'testB', 'job_id' => 11, 'job_title' => 'Designer', 'shared_attributes' => 2, 'match_rate' => 50 }
        ]
      )
    end

    it 'generates a CSV report' do
      csv_double = double('csv')
      allow(CSV).to receive(:open).with('job_match_report.csv', 'w').and_yield(csv_double)
      allow(csv_double).to receive(:<<)

      service.generate_report

      expect(CSV).to have_received(:open).with('job_match_report.csv', 'w')
      expect(csv_double).to have_received(:<<).with(%w[jobseeker_id jobseeker_name job_id job_title matching_skill_count matching_skill_percent])
      expect(csv_double).to have_received(:<<).with([1, 'testA', 10, 'Developer', 3, 75])
      expect(csv_double).to have_received(:<<).with([2, 'testB', 11, 'Designer', 2, 50])
    end

    it 'logs an error message when report generation fails' do
      allow(CSV).to receive(:open).and_raise(StandardError, 'CSV error')
      allow(Rails.logger).to receive(:debug)
      service.generate_report
      expect(Rails.logger).to have_received(:debug).with(/Failed to generate report. Error: CSV error/)
    end
  end
end
