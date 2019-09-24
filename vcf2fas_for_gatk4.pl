#!usr/bin/perl -w
open (O,'<',$ARGV[0]);
open (P,'>','sequence3.fas');
while ($a = <O>){
		chomp $a;
		if ($a =~ /^#CHROM/){
				@list = split /\t+/, $a;
				$kk = 9;
				while ($list[$kk]){
						$seq{$list[$kk]}  = '';
						$kk++;
				}
		}
		elsif ($a !~ /^##/){
				@list1 = split /\t+/, $a;
				if ($list1[6] eq 'PASS'){
					  $ref = $list1[3];
					  $alt = $list1[4];
						$sig = length($alt);
						if ($sig == 1){
								$n = 9;
								while ($list[$n]){
										$gt = (split /:/, $list1[$n])[0];
										if($gt eq '0/0'){$hap = "$ref$ref";}
										elsif(($gt eq '0/1')or($gt eq '1/0')){$hap = "$ref$alt";}
										elsif($gt eq '1/1'){$hap = "$alt$alt";}
										elsif($gt eq './.'){$hap = "NN";}
										elsif($gt eq '0|0'){$hap = "$ref$ref";}
										elsif(($gt eq '0|1')or($gt eq '1|0')){$hap = "$ref$alt";}
										elsif($gt eq '1|1'){$hap = "$alt$alt";}
										elsif($gt eq '.|.'){$hap = "NN";}
										
										if($hap=~/AA/i){$Hap = 'A';}
										elsif($hap =~ /TT/i){$Hap = 'T';}
										elsif($hap =~ /CC/i){$Hap = 'C';}
										elsif($hap =~ /GG/i){$Hap = 'G';}
										elsif($hap =~ /NN/i){$Hap = 'N';}
										elsif(($hap =~ /AG/i)or($hap =~ /GA/i)){$Hap = 'R';}
										elsif(($hap =~ /CT/i)or($hap =~ /TC/i)){$Hap = 'Y';}
										elsif(($hap =~ /AC/i)or($hap =~ /CA/i)){$Hap = 'M';}
										elsif(($hap =~ /GT/i)or($hap =~ /TG/i)){$Hap = 'K';}
										elsif(($hap =~ /CG/i)or($hap =~ /GC/i)){$Hap = 'S';}
										elsif(($hap =~ /AT/i)or($hap =~ /TA/i)){$Hap = 'W';}
										$seq{$list[$n]} = "$seq{$list[$n]}"."$Hap";
										$n++;
								}
	#							print "finish";
						}
				}
				
		}else{next}
}
$cc = 9;
while($list[$cc]){
		print P ">$list[$cc]\n$seq{$list[$cc]}\n";
		$cc++;
}
