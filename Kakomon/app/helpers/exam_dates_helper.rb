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
    case @term
    when 'first_semester' then [["前期","first_semester"],["条件なし",""],["後期", "second_semester"],["通年", "year_round"],["前期集中","i_first_semester"],["後期集中", "i_second_semester"]]
    when 'second_semester' then [["後期", "second_semester"],["条件なし",""],["前期","first_semester"],["通年", "year_round"],["前期集中","i_first_semester"],["後期集中", "i_second_semester"]]
    when 'year_round' then [["通年", "year_round"],["条件なし",""],["前期","first_semester"],["後期", "second_semester"],["前期集中","i_first_semester"],["後期集中", "i_second_semester"]]
    when 'i_first_semester' then [["前期集中","i_first_semester"],["条件なし",""],["前期","first_semester"],["後期", "second_semester"],["通年", "year_round"],["後期集中", "i_second_semester"]]
    when 'i_second_semester' then [["後期集中", "i_second_semester"],["条件なし",""],["前期","first_semester"],["後期", "second_semester"],["通年", "year_round"],["前期集中","i_first_semester"]]
    else [["条件なし",""],["前期","first_semester"],["後期", "second_semester"],["通年", "year_round"],["前期集中","i_first_semester"],["後期集中", "i_second_semester"]]
    end
  end
end
