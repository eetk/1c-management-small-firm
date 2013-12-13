use Text::Iconv;
 
@ARGV || die " Usage:
    scriptname file1 file2 ...
    scriptname \"file name\" ...
    scriptname file\\ name ...
    scriptname \*.mp3
    scriptname \*";
 
sub translit
{
    my $text = shift;
    $text = Text::Iconv->new("","koi-8")->convert($text);
    $text =~ y/ ÁÂ×ÇÄÅ£ÚÉÊËÌÍÎÏÐÒÓÔÕÆÈßÙØÜ/_abvgdeezijklmnoprstufh'y'e/;
    $text =~ y/áâ÷çäå³úéêëìíîïðòóôõæèÿùøü/ABVGDEEZIJKLMNOPRSTUFH'Y'E/;
    my %mchars = ('Ö'=>'zh','Ã'=>'tz','Þ'=>'ch','Û'=>'sh','Ý'=>'sch','À'=>'ju','Ñ'=>'ja',
                  'ö'=>'ZH','ã'=>'TZ','þ'=>'CH','û'=>'SH','ý'=>'SCH','à'=>'JU','ñ'=>'JA');
 
    map {$text =~ s/$_/$mchars{$_}/g} (keys %mchars);
 
    return $text;
}
 
while (@ARGV)
{
  rename($ARGV[0],translit($ARGV[0])) || die "Can't rename $ARGV[0] to translit($ARGV[0]): $!";
  shift;
}