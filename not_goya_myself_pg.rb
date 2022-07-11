require 'pg'

connection = PG::connect(dbname:"goya")
connection.internal_encoding = "UTF-8"
begin
  result = connection.exec("select * from crops join prices on crops.give_for = prices.give_for where NOT crops.give_for = '自家消費';")

result.each do |record|
  puts "ゴーヤの長さ：#{record["length"]} ゴーヤの重さ：#{record["weight"]} ゴーヤの品質：#{record["quality"]}売った相手：#{record["give_for"]} 売った金額：#{record["price"]} 収穫した日付：#{record["date"]}"
end
ensure
  connection.finish
end
