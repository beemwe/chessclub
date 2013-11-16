# encoding = utf-8
class Float
  def to_result
    if self.zero?
      result = '0'
    elsif self == 0.5
      result = '½'
    else
      result = self.floor.to_s
      result += '½' if self != self.floor
    end
    result
  end
end