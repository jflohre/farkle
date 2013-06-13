Given(/^I am on the home page$/) do
  visit '/'
end

Then(/^I should see "(.*?)"$/) do |string|
  assert page.has_content?(string)
end

When(/^I press the button "(.*?)"$/) do |button|
  click_button(button)
end

