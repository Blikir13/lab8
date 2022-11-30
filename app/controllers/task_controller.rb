# frozen_string_literal: true

# comment
class TaskController < ApplicationController
  before_action :error, only: :show
  def input; end

  def show
    @number = params[:number].split(' ')
    @podarray = cons(edit(@number.map(&:to_i)))
    @s = max(edit(@number.map(&:to_i)))
  end

  private

  # поиск максимальных подпоследователностей и вывод в строку
  def max(array)
    arr = array.clone
    s = ''
    arr.sort_by!(&:size).map { |el| s += "#{el.join(' ')}, " if el.size == arr[-1].size }
    s[0...s.length - 2]
  end

  # разделение последовательности на возрастающие подпоследовательнсоти
  def edit(mas)
    ar = []
    m = 0
    (0..mas.count - 2).each do |i|
      if mas[i] >= mas[i + 1]
        ar << mas[m..i]
        m = i + 1
      end
    end
    ar << mas[m..mas.count - 1]
    ar.select { |x| x.length > 1 }
  end

  # разделение на подпоследовательности
  def cons(mas)
    a = []
    mas.each { |x| (2..x.size).each { |n| x.each_cons(n) { |el| a.push(el) } } }
    a
  end

  # описание возможных ошибок
  def error
    params[:number].split(' ').each do |x|
      next unless x.match(/^-?[0-9]\d*$/).nil?

      return redirect_to root_path, notice: "Вы ввели не число / не целое число: #{x}"
    end
    redirect_to root_path, notice: 'Вы ввели меньше 10 чисел' if params[:number].split(' ').size < 10
  end
end
