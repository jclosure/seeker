
class Combinator
  
  def generate_combos(*list)
    list = list[0] if list[0].is_a? Array rescue list #handles when list items are not splatted
    output = list.sort_by { rand }.permutation(list.length).map { |j, k| j.to_s + k.to_s }
    p output.reduce { |j, k| j + ", " + k }
    output
  end
  
  def add_prefix(ix, *list)
       list = list[0] if list[0].is_a? Array rescue list #handles when list items are not splatted
       add_ix(list, :before) { ix }
   end
   
   def add_suffix(ix, *list)
        list = list[0] if list[0].is_a? Array rescue list #handles when list items are not splatted
        add_ix(list, :after) { ix }
    end
  
   def add_ix(list, place)
        ix = ''
        ix = yield if block_given?
        list = list.sort_by { rand }
        output = list.map { |j| j.to_s + ix.to_s } if place == :after
        output = list.map { |j| ix.to_s + j.to_s } if place == :before
        p output.reduce { |j, k| j + ", " + k }
        output
    end
  
 
end