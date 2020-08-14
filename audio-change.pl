#!/usr/bin/perl
#Corsair String: Corsair VOID PRO Wireless Gaming Headset Digital
#Speakers String: Family 17h 
#Earbuds String: Unitek Y-247A

use Desktop::Notify;

$desiredDevice = $ARGV[0];

$cmd = 'pacmd list-sinks | grep -e "index" -e "device.description"';
@output = `$cmd`;
$pos = 0;
foreach (@output){
    #print("$pos --- $_\n");
    if (index($_, $desiredDevice) != -1){
        @indxStr = split(': ',$output[$pos-1]);
        $indexNumber = $indxStr[1];
        $indexNumber =~ s/\s+$//;
        $fullDeviceName = $_;
        @dname = split('= ',$fullDeviceName);
        #print($dname[1]);
        last;
    }
    $pos++;
}
$executeCmd = "pacmd set-default-sink $indexNumber";
@return = `$executeCmd`;

$cmd2 = 'pacmd list-sink-inputs | grep index';
@output2 = `$cmd2`;
foreach (@output2){
    @inputstr = split(': ',$_);
    $inputindex = $inputstr[1];
    $inputindex =~ s/\s+$//;
    $cmd3 = "pacmd move-sink-input $inputindex $indexNumber";
    `$cmd`;
}

my $notify = Desktop::Notify->new();
my $notification = $notify->create(summary => 'Audio Output Changed',
                                   body => "Audio Device set to: \n$dname[1]",
                                   timeout => 5000);
$notification->show();