$file = 'c:\Users\Casper\Desktop\english_aircraft\lib\data\grammar_data_topic_g.dart'
$content = Get-Content $file -Raw
$content = $content.Replace('= yet' + [char]13 + [char]10 + [char]13 + [char]10 + 'arsiz', '= yetersiz')
$content | Set-Content $file -NoNewline
