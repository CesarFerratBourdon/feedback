module NavigationHelpers
  def create_admin
    user = User.new(first_name: "John", last_name: "Smith", username: "jsmith", email: "chris+jsmith@cryptographi.com", password: 'muffins1', password_confirmation: 'muffins1', job_title: 'HR Rep')
    company_domain = "cryptographi.com"
    team = Team.create(domain_name: company_domain, name: "Meow Corp", team_size: 21)
    user.team = team
    if user.save
      team.creator_id = user.id
      team.save
      user.add_role :admin
    end
  end

  # this method assumes that create_admin was run first
  def create_manager
    user = User.new(first_name: "Ralph", last_name: "Wiggum", username: "rwiggum", email: "chris+rwiggum@cryptographi.com", password: 'muffins1', password_confirmation: 'muffins1', job_title: 'Manager')
    company_domain = "cryptographi.com"
    team = Team.find_by(domain_name: company_domain)
    if !team
      create_admin
    end
    user.team = team
    manager = User.find_by(email: 'chris+jsmith@cryptographi.com')
    user.manager_id = manager.id
    if user.save
      user.add_role :manager
    end
  end

  # this method addumes that create_manager was run first
  def create_employee
    user = User.new(first_name: "Nelson", last_name: "Muntz", username: "nmuntz", email: "chris+nmuntz@cryptographi.com", password: 'muffins1', password_confirmation: 'muffins1', job_title: 'Worker Guy')
    company_domain = "cryptographi.com"
    team = Team.find_by(domain_name: company_domain)
    if !team
      create_manager
      team = Team.find_by(domain_name: company_domain)
    end
    user.team = team
    manager = User.find_by(email: 'chris+rwiggum@cryptographi.com')
    user.manager_id = manager.id
    if user.save
      user.add_role :employee
    end
  end

  def log_in_as(role)
    case role
    when 'admin'
      visit new_user_session_path
      fill_in('Email address', :with => 'chris+jsmith@cryptographi.com')
      fill_in('Password', :with => 'muffins1')
      click_button('SUBMIT')
    when 'manager'
      visit new_user_session_path
      fill_in('Email address', :with => 'chris+rwiggum@cryptographi.com')
      fill_in('Password', :with => 'muffins1')
      click_button('SUBMIT')
    when 'employee'
      visit new_user_session_path
      fill_in('Email address', :with => 'chris+nmuntz@cryptographi.com')
      fill_in('Password', :with => 'muffins1')
      click_button('SUBMIT')
    end
  end

end

World(NavigationHelpers)