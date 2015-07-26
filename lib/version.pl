# Es un simple esbozo.  TODO:

#  - Eliminar peticiones HTTP innecesarias
#  - Mejorar el fingerprint de la rama 2.5.X
#  - Eliminar la ingente cantidad de código mierda
#  - Afinar más el fingerprint



sub version {
	$ua = LWP::UserAgent->new();
	$ua->agent($flag_useragent);
	$version = direct();
	if ($version eq "UNKNOW") {
		$version = fingerprint();
	}
print "[+] Joomla! Version: $version\n\n";
}

sub direct {
	$url = $flag_url."/language/en-GB/en-GB.xml";
	$req = $ua->get($url);
	$html = $req->decoded_content;
	if ($html =~ m/\<version\>(.*?)\<\/version\>/g) {
		$version = $1;
	} else {
		$version = "UNKNOW";
	}
        $url = $flag_url."/administrator/manifests/files/joomla.xml";
        $req = $ua->get($url);
        $html = $req->decoded_content;
        if ($html =~ m/\<version\>(.*?)\<\/version\>/g) {
                $version = $1;
        } else {
                $version = "UNKNOW";
        }

}

sub fingerprint {
	$url = $flag_url."/media/system/js/mootools-more.js";
	$req = $ua->get($url);
	$html = $req->decoded_content;
	if ($html =~ m/version\:"(.*?)"/g) {
		$check = $1;
		if ($check eq "1.3.0.1") {
			$version = "1.6-1.6.6"; 
			$req = $ua->get($flag_url."/language/en-GB/en-GB.ini");
			$html = $req->decoded_content;
			if ($html =~ m/en\-GB\.ini (.*?) /g) { 
				$check = $1;
				if ($check eq "19767") { $version = "1.6"; }
				if ($check eq "20324") { $version = "1.6.1";}
				if ($check eq "20196") { $version = "1.6.0";}
				if ($check eq "20990") { $version = "1.6.2-1.6.6"; }
			}
		} 
		if ($check eq "1.3.2.1") {
			$version = "1.7.0-1.7.5";
			$req = $ua->get($flag_url."/language/en-GB/en-GB.ini");
			$html = $req->decoded_content;
			if ($html =~ m/en\-GB\.ini (.*?) /g) {
				$check = $1;
				if ($check eq "20990") { $version = "1.7.0-1.7.2";}
				if ($check eq "22183") { $version = "1.7.3-1.7.5";}
			}
		}
		if ($check eq "1.4.0.1") { 
			$req = $ua->get($flag_url."/media/jui/js/bootstrap.js");
			if ($req->status_line !~ /200/) {
				$version = "2.5.0-2.5.28";
                        	$req = $ua->get($flag_url."/media/system/js/mootools-core.js");
                        	$html = $req->decoded_content;
                        	if ($html =~ m/version\:"(.*?)"/g) { 
					$check = $1;
					if ($check eq "1.4.2") { $version = "2.5.0"; }
					if ($check eq "1.4.3") { $version = "2.5.1-2.5.3"; }
					if ($check eq "1.4.4") { $version = "2.5.4"; }
					if ($check eq "1.4.5") {
						$req = $ua->get($flag_url."/language/en-GB/en-GB.lib_joomla.ini");
						$html = $req->decoded_content;
						if ($html !~ /JLIB_UPDATER_ERROR_COLLECTION_PARSE_URL\=/) {
							$version = "2.5.4-2.5.5";
						} else {  
							$version = "2.5.6-2.5.28"; 
						}
					}
				}
			} else {
				$version = "3.0.0-3.4.1";
				$req = $ua->get($flag_url."/media/jui/js/ajax-chosen.js");
				if ($req->status_line !~ /200/) {
					$version = "3.0.0-3.0.3";
				} else {
					$version = "3.1.0-3.4.1";
					$req = $ua->get($flag_url."/media/com_banners/banner.js");
					if ($req->status_line !~ /200/) {
						$version = "3.1.0-3.1.6";
					} else {
						$version = "3.2.0-3.4.1";
						
					}
				}
			}
		}
	} else {
		$version = "UNKNOW";
	} 

}


1;
