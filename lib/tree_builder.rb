class TreeBuilder
  attr_reader :tree, :line, :comment_thread
  def initialize(comment_thread)
    @tree = [[true, false]]
    @render = ""
    @line = 0
    @comment_thread = comment_thread
    root_build comment_thread
  end
  def build(comment)
    last_comment = comment.replies.last.id
    comment.replies.each do |ecomment|
      shred
      @tree << @tree[-1] + [true,true,true]
      @tree << @tree[-2] + (ecomment.replies.any? ? [false,true] : [false,false])
      @tree[-1][-3] = false if last_comment == ecomment.id
      build ecomment if ecomment.replies.any?
    end
  end
  def root_build(thread)
    comments = thread.comments.select { |comment| comment.comment_id == nil }
    last_comment = comments.last.try :id
    comments.each do |ecomment|
      shred
      @tree[-1] << false
      @tree << @tree[-1] + [true,true]
      @tree[-1][-3] = true
      @tree << @tree[-2] + (ecomment.replies.any? ? [true,false] : [false,false])
      shred(3)
      @tree[-1][-1] = false if last_comment == ecomment.id
      build ecomment if ecomment.replies.any?
    end
  end
  def render()
    @tree.each.with_index do |row, x|
      row_string = ""
      row.each.with_index do |item, y|
        dir = 0
        if item
          # Up
          if x != 0 and @tree[x-1] and @tree[x-1][y]
            dir = dir + 1
          end
          # Down
          if @tree[x+1] and @tree[x+1][y]
            dir = dir + 4
          end
          # Left
          if y != 0 and @tree[x] and @tree[x][y-1]
            dir = dir + 8
          end
          # Right
          if @tree[x] and @tree[x][y+1]
            dir = dir + 2
          end
        end
        row_string << case dir
        when 0 then "   "
        when 1 then " ┃ "
        when 2 then "━━━"
        when 3 then " ┗━"
        when 4 then " ┃ "
        when 5 then " ┃ "
        when 6 then " ┏━"
        when 7 then " ┣━"
        when 8 then ""
        when 9 then "━┛ "
        when 10 then "━━━"
        when 11 then "━┻━"
        when 12 then "━┓ "
        when 13 then "━┫ "
        when 14 then "━┳━"
        when 15 then "━╋━"
        end
      end
      @render << row_string + "\n"
    end
    @render
  end
  def line(numb)
    return @render.split("\n")[numb]
  end
  def full
    puts @render
  end
  def fast_render()
    @tree.each do |row|
      row_string = ""
      row.each do |item|
        row_string << (item ? "+" : " ")
      end
      puts row_string
    end
  end
  def next(escape = false)
    @line = @line + 1
    return line(@line-1)
  end
  def current(escape = false)
    if line(@line) then return (escape ? line(@line).sub(" ", "&nbsp;") : line(@line)) end
  end
  def shred(limit = -1)
    blimit = limit
    until @tree[-1].pop or blimit == 0
      blimit = blimit -1
    end
    @tree[-1] << true
    if @tree[-2]
      until @tree[-2].pop or limit == 0
        limit = limit -1
      end
      @tree[-2] << true
    end
  end
  def prev
    return line(@line-1)
  end
end
