use v6;
use Test;
use lib 'lib';
use QDBus;
my $var = Q:to/END/;
[Argument: a{sv} {"Name" = [Variant(QString): "WiFi"], "Type" = [Variant(QString): "wifi"], "Powered" = [Variant(bool): true], "Connected" = [Variant(bool): true], "Tethering" = [Variant(bool): false]}]
END
my $parse = qdbus.new.parse($var);
is $parse.gist.lines.elems, 24;
# Snippets
ok Q<"Proxy.Configuration" = [Variant: [Argument: a{sv} {}]]> ~~ /<qdbus::variant>/;
ok Q<[Argument: a{sv} {}]> ~~ /<qdbus::argument>/;

# Non-snippets
my $answer2 = Q:to/ENDing/;
[Argument: a{sv} {"Proxy.Configuration" = [Variant: [Argument: a{sv} {}]], "Provider" = [Variant(QString): "WiFi"]}]
ENDing
is qdbus.new.parse($answer2).gist.lines.elems, 12;

done-testing;
