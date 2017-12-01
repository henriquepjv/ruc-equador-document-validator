class RucEquador
  attr_reader :document
  require_relative './ruc_natural'
  require_relative './ruc_privada'
  require_relative './ruc_publica'

  def initialize(document)
    @document = document
  end

  def validate
    return false if self.document.nil?

    ruc_kind = build

    return false unless !ruc_kind.nil?
    return false unless valid_ruc_format?
    return false unless valid_province_code?
    return false unless valid_last_ruc_digits?
    verify_digit(ruc_kind)
  end

  private

  def build
    kind_digit = document[2].to_i
    if kind_digit >= 0 && kind_digit < 6
      RucNatural.new(document)
    elsif kind_digit == 9
      RucPrivada.new(document)
    elsif kind_digit == 6 && document[9].to_i == 0
      RucPublica.new(document)
    end
  end

  def valid_ruc_format?
    !!(document =~/^[0-9]{13}$/)
  end

  def valid_province_code?
    province_digit = document[0..1].to_i
    province_digit >= 0 && province_digit < 25
  end

  def valid_last_ruc_digits?
    last_digit = document[12].to_i
    document[10..11] == '00' && last_digit >= 1 && last_digit <= 3
  end

  def verify_digit(ruc_kind)
    first_digits = ruc_kind.collect_first_digits
    coefficient = ruc_kind.find_coefficient

    total = first_digits.zip(coefficient).map{ |x, y| x.to_i * y }
    total_verified = []

    total.each do |num|
      if num >= 10
        first_element = num.to_s[0]
        second_element = num.to_s[1]

        new_element = first_element.to_i + second_element.to_i
        total_verified << new_element
      else
        total_verified << num.to_i
      end
    end

    verified_elements_sum = total_verified.inject(:+)
    valid_digit?(verified_elements_sum, ruc_kind)
  end

  def valid_digit?(verified_elements_sum, ruc_kind)
    divisible_result = verified_elements_sum % ruc_kind.module_operator

    if divisible_result == 0
      ruc_kind.return_verify_digit_value == 0
    else
      ruc_kind.module_operator - divisible_result ==
        ruc_kind.return_verify_digit_value
    end
  end
end
