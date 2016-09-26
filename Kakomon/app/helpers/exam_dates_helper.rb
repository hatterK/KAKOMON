module ExamDatesHelper
  def japanese_term(term)
    case term
    when 'first_semester' then '前期'
    when 'second_semester' then '後期'
    when 'year_round' then '通年'
    when 'i_first_semester' then '前期集中'
    when 'i_second_semester' then '後期集中'
    else term
    end
  end
end
