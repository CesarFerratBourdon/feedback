require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))


Given /^I am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I press "([^\"]*)"$/ do |button|
  click_button(button)
end

When /^I click "([^\"]*)"$/ do |link|
  click_link(link)
end

When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
  # fill_in(field.gsub(' ', '_'), :with => value)
end

When /^I fill in "([^\"]*)" for "([^\"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

When /^I fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^I select "([^\"]*)" from "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^I check "([^\"]*)"$/ do |field|
  check(field)
end

When /^I uncheck "([^\"]*)"$/ do |field|
  uncheck(field)
end

When /^I choose "([^\"]*)"$/ do |field|
  choose(field)
end

Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  page.should have_content(regexp)
end

Then /^I should not see "([^\"]*)"$/ do |text|
  page.should_not have_content(text)
end

Then /^I should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  page.should_not have_content(regexp)
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, value|
  find_field(field).value.should =~ /#{value}/
end

Then /^the "([^\"]*)" field should not contain "([^\"]*)"$/ do |field, value|
  find_field(field).value.should_not =~ /#{value}/
end

Then /^the "([^\"]*)" checkbox should be checked$/ do |label|
  find_field(label).should be_checked
end

Then /^the "([^\"]*)" checkbox should not be checked$/ do |label|
  find_field(label).should_not be_checked
end

Then /^I should be on (.+)$/ do |page_name|
  current_path.should == path_to(page_name)
end

Then /^page should have (.+) message "([^\"]*)"$/ do |type, text|
  bootstrap_name = "alert-success"
  case type

  when 'error'
    bootstrap_name = "alert-warning"
  end
  expect(page.has_css?("div.#{bootstrap_name}", :text => /.*#{text}/, :visible => true)).to eq(true)
end


Given(/^a manager account and a user account already exist$/) do
  create_employee
end

When(/^I am in the (.*)'s browser$/) do |name|
  Capybara.session_name = name

end

When(/^I am logged in as the (.*)$/) do |role|
  log_in_as role
end

When(/^I visit the employee's goals page$/) do
  visit '/team'
  within '.teamMemberRow' do
    click_link('GOALS')
  end
end

When(/^I visit the employee's feedback page$/) do
  visit '/team'
  within '.teamMemberRow' do
    click_link('FEEDBK')
  end
end

When(/^I visit my goals page$/) do
  visit '/team'
  within '.currentUserNameAndUsername' do
    click_link('GOALS')
  end
end

When(/^I click on the goal named "([^\"]*)"$/) do |goal_name|
  click_link(goal_name)
end




Given(/^an admin account already exists for the same email and password$/) do
  create_admin
end

Then(/^I attach a photo file to the "(.*?)" field$/) do |field|
  attach_file(field.gsub(' ', '_'), Rails.root + "spec/fixtures/emu.jpg")
end

Given(/^an admin account already exists for the same email domain$/) do
  create_admin
end

Given(/^a manager account already exists for the same email and password$/) do
  create_manager
end

Given(/^an employee account already exists for the same email and password$/) do
  create_employee
end

When(/^I open the page for debugging$/) do
  save_and_open_page
end

And(/^I sleep for debugging$/) do
  sleep 10000
end

When(/^I click the datepicker input box$/) do
  page.find(".a-datepicker").click
end

When(/^I click a date$/) do
  page.find('table.picker__table').find_all('tr')[2].find_all('td')[2].find('div').click
end

When(/^I visit my feedback page$/) do
  visit '/team'
  within '.currentUserNameAndUsername' do
    click_link('FEEDBK')
  end
end

When(/^I click on the reply button for the feedback named "(.*?)"$/) do |arg1|
  within '.prettyListItem' do
    click_link('REPLY')
  end
end



