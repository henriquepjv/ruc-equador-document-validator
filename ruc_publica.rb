class RucPublica
  attr_reader :document

  def initialize(document)
    @document = document
  end

  def collect_first_digits
    document[0..7].scan(/\w/)
  end

  def find_coefficient
    [3, 2, 7, 6, 5, 4, 3, 2 ]
  end

  def module_operator
    11
  end

  def return_verify_digit_value
    document[8].to_i
  end
end
