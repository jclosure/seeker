
class Combinator
  
  def generate_combos(*list)
    list = list[0] if list[0].is_a? Array rescue list #handles when list items are not splatted
    output = list.sort_by { rand }.permutation(list.length).map { |j, k| j.to_s + k.to_s }
    p output.reduce { |j, k| j + ", " + k }
    output
  end
  
end