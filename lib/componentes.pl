sub enumerate_ex {
	banner_ex();
	my $url = $flag_url;
	my $ua = LWP::UserAgent->new();
        $ua->agent($flag_useragent);
	open (EX, "<", "./data/components.txt");
	@com_dirty = <EX>;
	foreach $linea (@com_dirty) {     
			$req = $ua->get($url."/components/".$linea);
			if ($req->status_line !~ /404/ and $req->status_line !~ /403/) {
				print "[+] ".$linea; &exploitdb($linea);
			}
	}
}

sub banner_ex {
print q(

[!] Printing all components found!

);
}

























1;
