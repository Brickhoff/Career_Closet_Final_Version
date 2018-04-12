Given /^the following admins exist:$/ do |admins_table|
    admins_table.hashes.each do |admin|
        Admin.create admin
    end
end

Given /^the following users exist:$/ do |users_table|
    users_table.hashes.each do |user|
        User.create user
    end
end

Given /^the following renters exist:$/ do |renters_table|
    renters_table.hashes.each do |renter|
        Renter.create renter
    end
end

Given /^the following suits exist:$/ do |suits_table|
    suits_table.hashes.each do |suit|
        Suit.create suit
    end
end

Given /^the following appointments exist:$/ do |appointments_table|
    appointments_table.hashes.each do |appointments|
        Appointment.create appointments
    end
end