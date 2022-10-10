require "employee"

class Startup

  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name, @funding, @salaries = name, funding, salaries
    @employees = []
  end

  def valid_title?(title)
    return @salaries.has_key?(title)
  end

  def >(other_startup)
    return @funding > other_startup.funding
  end

  def hire(employee_name, title)
    if valid_title?(title)
      @employees << Employee.new(employee_name, title)
    else
      raise RuntimeError.new "Invalid employee title"
    end
  end

  def size
    return @employees.length
  end

  def pay_employee(employee)
    salary = @salaries[employee.title]
    if @funding - salary >= 0
      employee.pay(salary)
      @funding -= salary
    else
      raise RuntimeError.new "Not enough funding to pay employee"
    end
  end

  def payday
    @employees.each {|em| pay_employee(em)}
  end

  def average_salary
    salary_sum = 0
    @employees.each {|em| salary_sum += @salaries[em.title]}
    return salary_sum / (size * 1.0)
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(other_startup)
    @funding += other_startup.funding
    @salaries = {**other_startup.salaries, **@salaries}
    @employees = [*@employees, *other_startup.employees]
    other_startup.close
  end

end
