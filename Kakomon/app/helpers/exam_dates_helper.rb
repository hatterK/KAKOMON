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

  def term_option
    [["条件なし",""],["前期","first_semester"],["後期", "second_semester"],["通年", "year_round"],["前期集中","i_first_semester"],["後期集中", "i_second_semester"]]
  end
end
