sub enumerate_ex {
	banner_ex();
	my $url = $flag_url;
	my $ua = LWP::UserAgent->new();
	open (EX, "<", "./data/com-vul.txt");
	@com_dirty = <EX>;
	foreach $linea (@com_dirty) { 
		$linea = lc($linea);
		if ($linea =~ m/(.*?) /g) {    
			$ex = $1; 
			$req = $ua->get($url."/components/".$ex);
			if ($req->status_line !~ /404/) {
				print $linea;
			}
		}
	}
}

sub banner_ex {
print q(

[!] Checking for vulnerable components:

);
}



















1;
