require "csv"

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

memo_type = gets.to_i

if memo_type == 1
        
    puts "拡張子を除いたファイル名を入力してください"
    memo_name = gets.chomp
    puts "メモしたい内容を記入してください\nCtrl + Dで終了してください"
    memo_contents = readlines(chomp: true)
    CSV.open(memo_name + ".csv", "w") do |csv|
        csv.puts memo_contents
    end
        
elsif  memo_type == 2
        
    files = Dir.glob('*?.csv')
    if files.empty?
        puts "編集可能なファイルが存在しません。"
    else
        puts "編集可能なファイル一覧:"
        files.each_with_index { |f, index| puts "#{index + 1}. #{f}" }

        puts "編集するファイルの番号を選んでください"
        selected_file_index = gets.to_i
        if selected_file_index > 0 && selected_file_index <= files.length
            memo_name = files[selected_file_index - 1].chomp('.csv')
            memo = CSV.read(files[selected_file_index - 1])
            puts "メモの内容は\n#{memo}です\n1(追記する) 2(削除する) 3(編集せずに終了する)"

            edit_type = gets.to_i
            if edit_type == 1
                puts "追記したい内容を記入してください\nCtrl + Dで終了してください"
                puts "メモしたい内容を記入してください\nCtrl + Dで終了してください"
                  memo_contents = []
                while (line = gets)
                  memo_contents << line.chomp
                end

                CSV.open(memo_name + ".csv", "a") do |csv|
                    csv.puts memo_contents
                end
                puts "編集が完了しました"
            elsif edit_type == 2
                puts "削除したい配列の番号を記入してください\n例 [a], [b], [c]\n1 [b],[c]"
                arrangement_type = gets.chomp.to_i
                if arrangement_type > 0 && arrangement_type <= memo.length
                    memo.delete_at(arrangement_type - 1)
                    CSV.open(memo_name + ".csv", "w") do |csv|
                        memo.each do |row|
                            csv.puts row
                        end
                    end
                    puts "削除が完了しました"
                else
                    puts "無効な選択です"
                end
            elsif edit_type == 3
                puts "操作を終了します"
            else
                puts "正しい数字を入力してください"
            end
        else
            puts "無効な選択です"
        end
    end

else
    puts "正しい数字を入力してください"
end
