# Kum0nga Joomla Scan v0.1

# Coded by: X-C3LL

# Blog: 0verl0ad.net || ka0labs.net
# Twitter: @TheXC3LL


use Getopt::Long;
use LWP::UserAgent;

push(@INC, '.');
require 'lib/version.pl';
require 'lib/extensiones.pl';

GetOptions(
	"url=s" => \$flag_url,
	"version" => \$flag_version,
	"user-agent=s" => \$flag_useragent,
	"enum-vul" => \$flag_enum_vul,
);



banner();

unless ($flag_url) { help(); }
unless ($flag_useragent) { $flag_useragent = "Scanned by Kum0nga"; }
if ($flag_version) { version(); }
if ($flag_enum_vul) { enumerate_ex();}

sub banner {
print q(

[===================================================]
           ____                      ,
          /---.'.__             ____//
               '--.\           /.---'
          _______  \\         //
        /.------.\  \|      .'/  ______
       //  ___  \ \ ||/|\  //  _/_----.\__
      |/  /.-.\  \ \:|< >|// _/.'..\   '--'
         //   \'. | \'.|.'/ /_/ /  \\
        //     \ \_\/" ' ~\-'.-'    \\
       //       '-._| :H: |'-.__     \\
      //           {/'==='\}'-._\     ||
      ||                        \\    \|
      ||                         \\    '
      |/                          \\
                                   ||
    Kum0nga v0.1                   ||
    Joomla! Scanner                \\
                                    '
[==================================================]

);
}

sub help {
print q(
Usage: perl kumonga.pl <URL> <OPTIONS>

OPTIONS:
   --version   => Check Joomla! version
   --enum-vul  => Enumerate extensions and prompt known vulnerabilities
);
}
